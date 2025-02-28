import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  // A mapping of country codes to dialing codes
  final Map<String, String> countryDialingCodes = {
    "US": "+1",
    "IN": "+91",
    "GB": "+44",
    "CA": "+1",
    "AU": "+61",
    "DE": "+49",
    "FR": "+33",
    "JP": "+81",
    "CN": "+86",
    "BR": "+55",
    "ZA": "+27",
    // Add more country codes and their dialing prefixes as needed
  };

  Future<String?> getCurrentDialingCode() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // Request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied, cannot request permissions.');
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get placemark from coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Retrieve the ISO country code
      if (placemarks.isNotEmpty) {
        String? isoCountryCode = placemarks.first.isoCountryCode;
        // Map the ISO country code to the dialing code
        return countryDialingCodes[isoCountryCode];
      } else {
        throw Exception('No placemarks found for the given location.');
      }
    } catch (e) {
      print('Error: $e');
      return null; // Return null in case of an error
    }
  }
}
