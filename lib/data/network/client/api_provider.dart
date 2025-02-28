import 'dart:convert';
import 'dart:io';
import 'package:beurs/data/local/session_manager.dart';
import 'package:beurs/data/network/client/api_client.dart';
import 'package:beurs/data/network/client/connectivity_manager.dart';
import 'package:beurs/data/network/models/common_response.dart';
import 'package:beurs/generated/locales.g.dart';
import 'package:beurs/utility/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:logger/logger.dart';

/// Define own methods of all types of api's. Like., GET, POST..etc
abstract class IApiProvider {
  Future<Either<String, dynamic>?> getMethod<T>(
    String url, {
    Map<String, dynamic>? query,
  });

  Future<Either<String, dynamic>?> postMethod<T>(
    String url,
    dynamic body, {
    Progress? uploadProgress,
    Map<String, File>? files,
  });

  Future<Either<String, dynamic>?> putMethod<T>(String url, {dynamic body});

  Future<Either<String, dynamic>?> deleteMethod<T>(String url);
}

/// Common custom api provider with get connect
class ApiProvider extends GetConnect implements IApiProvider {
  final Logger _logger = Logger();

  @override
  void onInit() {
    httpClient.baseUrl = ApiClient.apiBaseUrl;
    httpClient.maxAuthRetries = 3;
  }

  @override
  Future<Either<String, dynamic>?> getMethod<T>(String url,
      {Map<String, dynamic>? query, bool isFullResponse = false}) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();
        var result =
            await get(ApiClient.apiBaseUrl + url, query: query, headers: {
          if (token != null) ...{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }
        });

        _logger.i('Token: $token');
        _logger.w('Get API: ${ApiClient.apiBaseUrl + url}');
        _logger.i('Response: ${result.body}');

        var commonResponse = CommonResponse<T>.fromJson(result.body);
        if (result.statusCode == Constants.isToken401 ||
            result.statusCode == Constants.isToken403) {
          StorageManager().setFromFresh(true);
        } else if (result.statusCode == Constants.isSuccess200) {
          if (commonResponse.status == 1) {
            if (isFullResponse) {
              return Right(commonResponse);
            } else {
              return Right(commonResponse.data);
            }
          } else {
            return Left(commonResponse.statusMsg ?? '');
          }
        } else {
          return Left(commonResponse.statusMsg ?? '');
        }
      } else {
        _logger.e(LocaleKeys.checkYourInternetConnection.tr);
      }
    } catch (e, s) {
      _logger.e('Error: $e\nStackTrace: $s');
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
    return null;
  }

  @override
  Future<Either<String, dynamic>?> postMethod<T>(
    String url,
    dynamic body, {
    Progress? uploadProgress,
    Map<String, File>? files,
    bool isFormData = false,
    bool isWithBody = true,
    bool forSendMessage = false,
    bool isFullResponse = false,
  }) async {
    bool skipLogging = url.contains('SyncContact');

    try {
      if (!skipLogging) {
        _logger.i('postMethod called with URL: $url');
      }

      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        if (!skipLogging) {
          _logger.i('Token: $token');
          _logger.i('Post API: ${ApiClient.apiBaseUrl + url}');
        }

        http.Response result;

        if (isFormData && files != null) {
          if (!skipLogging) {
            _logger.i('Form data submission detected');
          }

          var request = http.MultipartRequest(
              'POST', Uri.parse(ApiClient.apiBaseUrl + url));

          // Add headers if token is available
          if (token != null) {
            request.headers['Authorization'] = 'Bearer $token';
          }

          // Add fields
          body.forEach((key, value) {
            request.fields[key] = value.toString();
          });

          // Add files
          files.forEach((key, file) async {
            request.files.add(await http.MultipartFile.fromPath(key, file.path,
                filename: basename(file.path)));
          });

          var streamedResponse = await request.send();
          result = await http.Response.fromStream(streamedResponse);

          if (!skipLogging) {
            _logger.i('FormData: ${request.fields}');
            _logger.i('Files: ${files.keys.join(", ")}');
            _logger.i('Response: ${result.body}');
          }
        } else {
          var headers = {
            'Content-Type': 'application/x-www-form-urlencoded',
            if (token != null) 'Authorization': 'Bearer $token',
          };

          result = await http.post(
            Uri.parse(ApiClient.apiBaseUrl + url),
            headers: headers,
            body: isWithBody ? body : null,
          );

          if (!skipLogging) {
            _logger.i('Request Body: $body');
            _logger.i('Response: ${result.body}');
          }
        }

        // Parse the response and pass it to CommonResponse
        var jsonResponse = json.decode(result.body);
        var commonResponse = CommonResponse<T>.fromJson(jsonResponse);

        if (result.statusCode == Constants.isToken401 ||
            result.statusCode == Constants.isToken403) {
          StorageManager().setFromFresh(true);
          return null;
        } else if (result.statusCode == Constants.isSuccess200) {
          if (commonResponse.status == 1) {
            if (commonResponse.data == null) {
              return Right(commonResponse);
            } else {
              if (isFullResponse) {
                return Right(commonResponse);
              }
              if (isWithBody) {
                return Right(commonResponse.data);
              } else {
                return Right(commonResponse.statusMsg);
              }
            }
          } else {
            return Left(commonResponse.statusMsg ?? "");
          }
        } else {
          return Left(commonResponse.statusMsg ?? "");
        }
      } else {
        return Left(LocaleKeys.checkYourInternetConnection.tr);
      }
    } catch (e, s) {
      if (!skipLogging) {
        _logger.e('Error: $e\nStackTrace: $s');
      }
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
    return null;
  }

  @override
  Future<Either<String, dynamic>?> putMethod<T>(String url,
      {dynamic body}) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        var result = await put(ApiClient.apiBaseUrl + url, body, headers: {
          if (token != null) ...{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }
        });

        _logger.w('Put API: ${ApiClient.apiBaseUrl + url}');
        _logger.i('Response: ${result.body}');

        var commonResponse = CommonResponse<T>.fromJson(result.body);
        if (result.statusCode == Constants.isToken401 ||
            result.statusCode == Constants.isToken403) {
          StorageManager().setFromFresh(true);
        } else if (result.statusCode == Constants.isSuccess200) {
          if (commonResponse.status == 1) {
            return Right(commonResponse.data);
          } else {
            return Left(commonResponse.statusMsg ?? '');
          }
        } else {
          return Left(commonResponse.statusMsg ?? '');
        }
      } else {
        return Left(LocaleKeys.checkYourInternetConnection.tr);
      }
    } catch (e, s) {
      _logger.e('Error: $e\nStackTrace: $s');
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
    return null;
  }

  @override
  Future<Either<String, dynamic>?> deleteMethod<T>(String url) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        var result = await delete(
          ApiClient.apiBaseUrl + url,
          headers: {
            if (token != null) ...{
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            }
          },
        );

        _logger.w('header: $token');
        _logger.w('Delete API: ${ApiClient.apiBaseUrl + url}');
        _logger.i('Response: ${result.body}');

        var commonResponse = CommonResponse<T>.fromJson(result.body);
        if (result.statusCode == Constants.isToken401 ||
            result.statusCode == Constants.isToken403) {
          StorageManager().setFromFresh(true);
        } else if (result.statusCode == Constants.isSuccess200) {
          if (commonResponse.status == 1) {
            return Right(commonResponse.data);
          } else {
            return Left(commonResponse.statusMsg ?? '');
          }
        } else {
          return Left(commonResponse.statusMsg ?? '');
        }
      } else {
        return Left(LocaleKeys.checkYourInternetConnection.tr);
      }
    } catch (e, s) {
      _logger.e('Error: $e\nStackTrace: $s');
      return Left(LocaleKeys.somethingWentWrong.tr);
    }
    return null;
  }
}
