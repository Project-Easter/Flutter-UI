import 'package:books_app/services/database.dart';
import 'package:books_app/utils/config.dart';
import 'package:books_app/utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:books_app/services/auth.dart';

// ignore: must_be_immutable
class GetLocation extends StatelessWidget {
  double lat;
  double long;

  final AuthService _authService = AuthService();
  final LocationHelper _locationHelper = new LocationHelper();

  @override
  Widget build(BuildContext context) {
    final uID = _authService.getUID;
    final DatabaseService databaseService = DatabaseService(uid: uID);
    return Scaffold(
      body: FutureBuilder(
        future: new Config().load(),
        builder: (BuildContext buildContext, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return MapboxMap(
              accessToken: snapshot.data['mapbox_api_token'],
              initialCameraPosition: CameraPosition(target: LatLng(45, 45)),
              onMapCreated: (MapboxMapController controller) async {
                final currentLocation = await this._locationHelper.getCurrentLocation();

                lat = currentLocation.latitude;
                long = currentLocation.longitude;
                final animateCameraResult = await controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(zoom: 3, target: currentLocation),
                  ),
                );

                await databaseService.updateUserLocation(lat, long);
                if (animateCameraResult) {
                  controller.addCircle(CircleOptions(
                    circleColor: '#333333',
                    circleRadius: 4,
                    geometry: currentLocation,
                  ));
                }
              },
              onStyleLoadedCallback: () {},
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
