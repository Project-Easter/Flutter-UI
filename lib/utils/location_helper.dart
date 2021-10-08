import 'package:latlong/latlong.dart';
// import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

class LocationHelper {
  Future<List<String>> getAddressFromLatLng(double lat, double lang) async {
    final Coordinates coordinates = Coordinates(lat, lang);
    final List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final Address first = add.first;
    return [first.subAdminArea, first.adminArea, first.countryName];
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

    return LatLng(locationData.latitude, locationData.longitude);
  }
}
