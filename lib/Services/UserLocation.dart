import 'package:books_app/Services/databaseService.dart';
import 'package:books_app/Utils/config_helper.dart';
import 'package:books_app/Utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:books_app/Services/Auth.dart';

class GetLocation extends StatelessWidget {
  double lat;
  double long;

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final uID = _authService.getUID;
    final DatabaseService databaseService = DatabaseService(uid: uID);
    return Scaffold(
      body: FutureBuilder(
        future: loadConfig(),
        builder: (BuildContext buildContext, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return MapboxMap(
              accessToken: snapshot.data['mapbox_api_token'],
              initialCameraPosition: CameraPosition(target: LatLng(45, 45)),
              onMapCreated: (MapboxMapController controller) async {
                final currLocation = await acquireCurrentLocation();
                lat = currLocation.latitude;
                long = currLocation.longitude;
                final animateCameraResult = await controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(zoom: 3, target: currLocation),
                  ),
                );

                await databaseService.updateUserLocation(lat, long);
                if (animateCameraResult) {
                  controller.addCircle(CircleOptions(
                    circleColor: '#333333',
                    circleRadius: 4,
                    geometry: currLocation,
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
