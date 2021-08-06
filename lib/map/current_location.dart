import 'package:books_app/Utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:latlong2/latlong.dart' as latlng;

class GetUserLocation extends StatefulWidget {
  @override
  _GetUserLocation createState() => _GetUserLocation();
}

class _GetUserLocation extends State<GetUserLocation> {
  final MapController mapController = MapController();
  double lat;
  double long;
  LatLngData ld;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
            future: Config().load(),
            builder: (BuildContext buildContext,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                return Stack(children: <Widget>[
                  Center(
                      child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        // center: ld.location,
                        plugins: <MapPlugin>[
                          // USAGE NOTE 2: Add the plugin
                          LocationPlugin(),
                        ], zoom: 18),
                    layers: <LayerOptions>[
                      TileLayerOptions(
                        urlTemplate:
                            'https://api.mapbox.com/styles/v1/williamtobs/ckry4f8gyacmu17p4xa77ccx2/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoid2lsbGlhbXRvYnMiLCJhIjoiY2tyeGQ2dzg2MDZwdzJubzlzbjBqMGMwayJ9.h2i_X9gCmDOjFD1sIF0ieA',
                        additionalOptions: {
                          'accessToken':
                              'pk.eyJ1Ijoid2lsbGlhbXRvYnMiLCJhIjoiY2tyeGQ2dzg2MDZwdzJubzlzbjBqMGMwayJ9.h2i_X9gCmDOjFD1sIF0ieA',
                          'id': 'mapbox.mapbox-streets-v7',
                        },
                      ),

                      // markerBuilder: (BuildContext context, LatLngData ld,
                      //     ValueNotifier<double> heading) {
                      //   return Marker(
                      //     point: ld.location,
                      //     builder: (_) => Container(
                      //         child: IconButton(
                      //             onPressed: () {
                      //               showModalBottomSheet<void>(
                      //                   context: context,
                      //                   builder: (BuildContext builder) {
                      //                     return Container(
                      //                       color: Colors.white,
                      //                       child: const Text(
                      //                         'Text',
                      //                       ),
                      //                     );
                      //                   });
                      //             },
                      //             icon: const Icon(
                      //               Icons.location_on,
                      //               color: Colors.blue,
                      //             ))),
                      //     height: 60.0,
                      //     width: 60.0,
                      //   );
                      // },
                      MarkerLayerOptions(
                        markers: <Marker>[
                          Marker(
                            point: ld.location,
                            height: 60.0,
                            width: 60.0,
                            builder: (BuildContext ctx) => IconButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext builder) {
                                        return Container(
                                          color: Colors.white,
                                          child: const Text(
                                            'Text',
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                )),
                          )
                        ],
                      )
                    ],
                    nonRotatedLayers: <LayerOptions>[
                      // USAGE NOTE 3: Add the options for the plugin
                      LocationOptions(
                        buttonBuilder: locationButton(),
                        onLocationUpdate: (LatLngData ld) async {
                          print(
                              'Location updated: ${ld?.location} (accuracy: ${ld?.accuracy})');
                          await getCurrentLocation();
                        },
                        onLocationRequested: (LatLngData ld) {
                          if (ld == null) {
                            return;
                          }
                          mapController.move(ld.location, 16.0);
                        },
                        markerBuilder: (BuildContext context, LatLngData ld,
                            ValueNotifier<double> heading) {
                          return Marker(
                            point: ld.location,
                            builder: (_) => Container(
                                child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext builder) {
                                            return Container(
                                              color: Colors.white,
                                              child: const Text(
                                                'Text',
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.location_on,
                                      color: Colors.blue,
                                    ))),
                            height: 60.0,
                            width: 60.0,
                          );
                        },
                      )
                    ],
                  ))
                ]);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

// markers: [
  //   Marker(
  //     point: ld.location,
  //     builder: (_) => Container(
  //         child: IconButton(
  //             onPressed: () {
  //               showModalBottomSheet<void>(
  //                   context: context,
  //                   builder: (BuildContext builder) {
  //                     return Container(
  //                       color: Colors.white,
  //                       child: const Text(
  //                         'Text',
  //                       ),
  //                     );
  //                   });
  //             },
  //             icon: const Icon(
  //               Icons.location_on,
  //               color: Colors.blue,
  //             ))),
  //     height: 60.0,
  //     width: 60.0,
  //   )
  // ],
  // markers: [
  //   Marker(
  //       height: 50.0,
  //       width: 50.0,
  //       point: ld.location,
  //       builder: (BuildContext ctx) => IconButton(
  //           onPressed: () {
  //             showModalBottomSheet<void>(
  //                 context: context,
  //                 builder: (BuildContext builder) {
  //                   return Container(
  //                     color: Colors.white,
  //                     child: const Text(
  //                       'Text',
  //                     ),
  //                   );
  //                 });
  //           },
  //           icon: const Icon(
  //             FontAwesomeIcons.mapMarkedAlt,
  //             color: Colors.blue,
  //           )))
  // ],
  //   ),
  Future<latlng.LatLng> getCurrentLocation() async {
    final Location location = Location();
    LocationData locationData;
    locationData = await location.getLocation();
    return latlng.LatLng(locationData.latitude, locationData.longitude);
  }

  LocationButtonBuilder locationButton() {
    return (BuildContext context, ValueNotifier<LocationServiceStatus> status,
        Function onPressed) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
          child: FloatingActionButton(
              child: ValueListenableBuilder<LocationServiceStatus>(
                  valueListenable: status,
                  builder: (BuildContext context, LocationServiceStatus value,
                      Widget child) {
                    switch (value) {
                      case LocationServiceStatus.disabled:
                      case LocationServiceStatus.permissionDenied:
                      case LocationServiceStatus.unsubscribed:
                        return const Icon(
                          Icons.location_disabled,
                          color: Colors.white,
                        );
                      default:
                        return const Icon(
                          Icons.location_searching,
                          color: Colors.white,
                        );
                    }
                  }),
              onPressed: () => onPressed()),
        ),
      );
    };
  }
}
