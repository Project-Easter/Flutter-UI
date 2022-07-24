// import 'package:geocode/geocode.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geocode/geocode.dart';
import 'package:latlong2/latlong.dart';
// import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

class LocationHelper {
  num calculateDistance(
      {double? lat1, double? lon1, double? lat2, double? lon2}) {
    const Distance distance = Distance();
    return distance.as(
        LengthUnit.Kilometer, LatLng(lat1!, lon1!), LatLng(lat2!, lon2!));
  }

  Future<List<String?>> getAddressFromLatLng(double lat, double lang) async {
    // final Coordinates coordinates = Coordinates(latitude: lat, longitude: lang);
    // final List<Placemark> addr = await placemarkFromCoordinates(lat, lang);
    final Address addr =
        await GeoCode().reverseGeocoding(latitude: lat, longitude: lang);
    // final Address first = add;
    return <String?>[addr.streetAddress, addr.city, addr.countryName];
  }

  Future<LatLng?> getCurrentLocation() async {
    final Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();

    return LatLng(locationData.latitude!, locationData.longitude!);
  }
}
