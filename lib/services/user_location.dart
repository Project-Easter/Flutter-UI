import 'package:books_app/Services/auth.dart';
import 'package:books_app/Utils/config.dart';
import 'package:books_app/Utils/location_helper.dart';
import 'package:books_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

// ignore: must_be_immutable
class GetLocation extends StatefulWidget {
  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  double lat;
  final String marker = MapboxStyles.TRAFFIC_DAY;

  double long;

  @override
  Widget build(BuildContext context) {
    final dynamic uID = AuthService().getUID;
    final DatabaseService databaseService =
        DatabaseService(uid: uID.toString());
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: Config().load(),
        builder: (BuildContext buildContext,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return MapboxMap(
              myLocationRenderMode: MyLocationRenderMode.COMPASS,
              zoomGesturesEnabled: true,
              myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
              // compassEnabled: true,
              accessToken: snapshot.data['mapbox_api_token'].toString(),
              onMapCreated: (MapboxMapController controller) async {
                final LatLng currLocation =
                    await LocationHelper().getCurrentLocation();
                // final LatLng l = currLocation;
                lat = currLocation.latitude;
                long = currLocation.longitude;

                final bool animateCameraResult = await controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(zoom: 5, target: LatLng(lat, long)),
                    //currLocation as LatLng
                  ),
                );

                await databaseService.updateUserLocation(lat, long);
                if (animateCameraResult) {
                  // controller.addCircle(CircleOptions(
                  //     circleColor: '#333333',
                  //     circleRadius: 5,
                  //     geometry: LatLng(lat, long)));
                  controller.addSymbol(SymbolOptions(
                      iconAnchor: 'Anchor check',
                      // textField: 'Testing',
                      geometry: LatLng(lat, long),
                      iconImage: 'assets/marker.png',
                      iconHaloBlur: 1
                      // iconSize: 5,
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
