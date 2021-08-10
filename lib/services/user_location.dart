// import 'package:books_app/Services/auth.dart';
// import 'package:books_app/Utils/config.dart';
// import 'package:books_app/Utils/location_helper.dart';
// import 'package:books_app/services/database_service.dart';
// import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

// // ignore: must_be_immutable
// class GetLocation extends StatefulWidget {
//   @override
//   _GetLocationState createState() => _GetLocationState();
// }

// class _GetLocationState extends State<GetLocation> {
//   double lat;
//   final String marker = MapboxStyles.TRAFFIC_DAY;

//   double long;

//   @override
//   Widget build(BuildContext context) {
//     final dynamic uID = AuthService().getUID;
//     final DatabaseService databaseService =
//         DatabaseService(uid: uID.toString());
//     return Scaffold(
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: Config().load(),
//         builder: (BuildContext buildContext,
//             AsyncSnapshot<Map<String, dynamic>> snapshot) {
//           if (snapshot.hasData) {
//             return MapboxMap(
//               trackCameraPosition: true,
//               myLocationRenderMode: MyLocationRenderMode.COMPASS,
//               zoomGesturesEnabled: true,
//               myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
//               // compassEnabled: true,
//               accessToken: snapshot.data['mapbox_api_token'].toString(),
//               onMapCreated: (MapboxMapController controller) async {
//                 final LatLng currLocation =
//                     await LocationHelper().getCurrentLocation();
//                 // final LatLng l = currLocation;
//                 lat = currLocation.latitude;
//                 long = currLocation.longitude;

//                 final bool animateCameraResult = await controller.animateCamera(
//                   CameraUpdate.newCameraPosition(
//                     CameraPosition(zoom: 5, target: LatLng(lat, long)),
//                     //currLocation as LatLng
//                   ),
//                 );

//                 await databaseService.updateUserLocation(lat, long);
//                 // Api.location(token);
//                 if (animateCameraResult) {
//                   // controller.addCircle(CircleOptions(
//                   //     circleColor: '#333333',
//                   //     circleRadius: 5,
//                   //     geometry: LatLng(lat, long)));
//                   controller.addSymbol(SymbolOptions(
//                       iconRotate: 2,
//                       iconAnchor: 'Anchor check',
//                       // textField: 'Testing',
//                       geometry: LatLng(lat, long),
//                       iconImage: 'assets/images/marker.png',
//                       iconHaloBlur: 1
//                       // iconSize: 5,
//                       ));
//                 }
//               },
//               initialCameraPosition:
//                   const CameraPosition(target: LatLng(45, 45)),
//               onStyleLoadedCallback: () {},
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:books_app/Utils/keys_storage.dart';
import 'package:books_app/Utils/location_helper.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/services/database_service.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLocation extends StatefulWidget {
  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  String address = '';
  String name = '';
  String streetAddress = '';

  @override
  Widget build(BuildContext context) {
    final dynamic _uID = AuthService().getUID;
    final DatabaseService _databaseService =
        DatabaseService(uid: _uID.toString());
    return Scaffold(
      // ignore: always_specify_types
      body: FutureBuilder(
        future: LocationHelper().getCurrentLocation(),
        builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            print(snapshot.data.latitude);

            return FlutterMap(
              options: MapOptions(
                center: LatLng(snapshot.data.latitude, snapshot.data.longitude),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate: TokenStorage.urlTemplate,
                    additionalOptions: {
                      'accessToken': TokenStorage.mapboxToken,
                      'id': TokenStorage.mapboxId,
                    }),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 120.0,
                      height: 120.0,
                      point: LatLng(
                          snapshot.data.latitude, snapshot.data.longitude),
                      builder: (BuildContext ctx) => Container(
                        child: IconButton(
                          icon: const Icon(
                            Icons.location_on,
                            size: 30,
                          ),
                          onPressed: () async {
                            await _databaseService.updateUserLocation(
                                snapshot.data.latitude,
                                snapshot.data.longitude);
                            await _getAddrress(snapshot.data.latitude,
                                snapshot.data.longitude);
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return Container(
                                    height: 150,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 2),
                                            color: Colors.blue[700],
                                            child: ListTile(
                                              trailing: Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                height: 80,
                                                width: 80,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: Icon(Icons.location_on,
                                                    color: Colors.blue[700],
                                                    size: 35),
                                              ),
                                              title: const Text(
                                                'Address',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                address,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            )),
                                        // ListTile(
                                        //   title: Text('Address'),
                                        //   subtitle: Text(address),
                                        // ),
                                        const SizedBox(),
                                        Container(
                                            height: 45,
                                            width: 150,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      13.0),
                                                          side:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .red))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.red)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Confirm',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            )),
                                        const SizedBox()
                                      ],
                                    ),
                                  );
                                });
                          },
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<void> _getAddrress(double latitude, double longitude) async {
    final List<Placemark> newPlace =
        await placemarkFromCoordinates(latitude, longitude);
    print(newPlace[0]);
    final Placemark placeMark = newPlace[0];
    name = placeMark.name;
    final String locality = placeMark.locality;
    streetAddress = placeMark.street;

    final String postalCode = placeMark.postalCode;
    final String country = placeMark.country;
    address = '$name, $locality, $postalCode, $country';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', address);
  }
}
