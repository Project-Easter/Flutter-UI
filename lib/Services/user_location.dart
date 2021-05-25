import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../Utils/config_helper.dart';
import '../Utils/location_helper.dart';
import 'auth.dart';
import 'database_service.dart';

// ignore: must_be_immutable
class GetLocation extends StatelessWidget {
  double lat;
  double long;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final dynamic uID = _authService.getUID;
    final DatabaseService databaseService = DatabaseService(uid: uID as String);
    return Scaffold(
      body: FutureBuilder(
        future: loadConfig(),
        builder: (BuildContext buildContext,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return MapboxMap(
              accessToken: snapshot.data['mapbox_api_token'].toString(),
              initialCameraPosition:
                  const CameraPosition(target: LatLng(45, 45)),
              onMapCreated: (MapboxMapController controller) async {
                final LatLng currLocation = await acquireCurrentLocation();

                lat = currLocation.latitude;
                long = currLocation.longitude;
                final bool animateCameraResult = await controller.animateCamera(
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
