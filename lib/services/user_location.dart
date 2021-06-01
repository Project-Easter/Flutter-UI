import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Services/database_service.dart';
import 'package:books_app/Utils/config.dart';
import 'package:books_app/Utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

// ignore: must_be_immutable
class GetLocation extends StatelessWidget {
  double lat;
  double long;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final dynamic uID = _authService.getUID;
    final DatabaseService databaseService =
        DatabaseService(uid: uID.toString());
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: Config().load(),
        builder: (BuildContext buildContext,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return MapboxMap(
              accessToken: snapshot.data['mapbox_api_token'].toString(),
              initialCameraPosition:
                  const CameraPosition(target: LatLng(45, 45)),
              onMapCreated: (MapboxMapController controller) async {
                final dynamic currLocation =
                    await LocationHelper().getCurrentLocation();

                lat = currLocation.latitude as double;
                long = currLocation.longitude as double;
                final bool animateCameraResult = await controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(zoom: 3, target: currLocation as LatLng),
                  ),
                );

                await databaseService.updateUserLocation(lat, long);
                if (animateCameraResult) {
                  controller.addCircle(CircleOptions(
                    circleColor: '#333333',
                    circleRadius: 4,
                    geometry: currLocation as LatLng,
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
