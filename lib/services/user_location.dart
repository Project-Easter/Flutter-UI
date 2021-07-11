import 'package:books_app/Services/auth.dart';
import 'package:books_app/Utils/config.dart';
import 'package:books_app/Utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

// ignore: must_be_immutable
class GetLocation extends StatelessWidget {
  double lat;
  double long;

  @override
  Widget build(BuildContext context) {
    final dynamic uID = AuthService().getUID;
    // final DatabaseService databaseService =
    //     DatabaseService(uid: uID.toString());
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: Config().load(),
        builder: (BuildContext buildContext,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return MapboxMap(
              accessToken: snapshot.data['mapbox_api_token'].toString(),
              onMapCreated: (MapboxMapController controller) async {
                final LatLng currLocation =
                    await LocationHelper().getCurrentLocation();
                final LatLng l = currLocation;
                // lat = currLocation.latitude as double;
                // long = currLocation.longitude as double;
                final bool animateCameraResult = await controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(zoom: 10, target: l),
                    //currLocation as LatLng
                  ),
                );

                // await databaseService.updateUserLocation(lat, long);
                if (animateCameraResult) {
                  controller.addCircle(CircleOptions(
                    circleColor: '#333333',
                    circleRadius: 4,
                    geometry: l,
                  ));
                }
              },
              initialCameraPosition:
                  const CameraPosition(target: LatLng(45, 45)),
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
