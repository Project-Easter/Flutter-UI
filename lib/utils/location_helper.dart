import 'dart:ffi';

import 'package:books_app/Utils/backend/user_data_requests.dart';
import 'package:books_app/Utils/helpers.dart';
import 'package:books_app/Utils/keys_storage.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
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

  Future<LatLng> getCurrentLocation() async {
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

    // final Response response = await UserRequests.location(
    //   TokenStorage.authToken,
    //   locationData.latitude ,
    //   locationData.longitude,
    // );
    // final dynamic body = await getBodyFromResponse(response);
    // print('$response is the Piotrrr backend location body');
    //  if(response.statusCode==204){

    //  }

    return LatLng(locationData.latitude, locationData.longitude);
  }

  // Future backendLoc()async {
  //    final Response response = await UserRequests.location(
  //     TokenStorage.authToken,
  //     locationData.latitude,
  //     locationData.longitude,
  //   );
  //   final dynamic body = await getBodyFromResponse(response);
  //   print('$response is the Piotrrr backend location response');
  //   if (response.statusCode == 204) {
  //     print('$body is the Piotrrr backend location body');
  //   }
  // }
}
