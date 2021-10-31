import 'package:books_app/services/auth.dart';
import 'package:books_app/services/database_service.dart';
import 'package:books_app/utils/keys_storage.dart';
import 'package:books_app/utils/location_helper.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

import 'package:shared_preferences/shared_preferences.dart';

class GetLocation extends StatefulWidget {
  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  String address = '';
  String? name = '';
  String? streetAddress = '';

  @override
  Widget build(BuildContext context) {
    final dynamic _uID = FirebaseAuthService().getUID;
    final DatabaseService _databaseService =
        DatabaseService(uid: _uID.toString());
    return Scaffold(
      // ignore: always_specify_types
      body: FutureBuilder<LatLng?>(
        future: LocationHelper().getCurrentLocation(),
        builder: (BuildContext context, AsyncSnapshot<LatLng?> snapshot) {
          if (snapshot.hasData) {
            //  Provider.of<UserData>(context).up
            // Provider.of<UserModel>(context).updateLocation(snapshot.data.latitude, snapshot.data.longitude);
            print(snapshot.data);
            print(snapshot.data!.latitude);
            return FlutterMap(
              options: MapOptions(
                center:
                    LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                zoom: 13.0,
              ),
              layers: <LayerOptions>[
                TileLayerOptions(
                    urlTemplate: TokenStorage.urlTemplate,
                    additionalOptions: <String, String>{
                      'accessToken': TokenStorage.mapboxToken,
                      'id': TokenStorage.mapboxId,
                    }),
                MarkerLayerOptions(
                  markers: <Marker>[
                    Marker(
                      width: 120.0,
                      height: 120.0,
                      point: LatLng(
                          snapshot.data!.latitude, snapshot.data!.longitude),
                      builder: (BuildContext ctx) => IconButton(
                        icon: const Icon(
                          Icons.location_on,
                          size: 30,
                        ),
                        onPressed: () async {
                          await _databaseService.updateUserLocation(
                              snapshot.data!.latitude,
                              snapshot.data!.longitude);
                          await _getAddrress(snapshot.data!.latitude,
                              snapshot.data!.longitude);
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext ctx) {
                                return Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          color: Colors.blue[700],
                                          child: ListTile(
                                            trailing: Container(
                                              padding: const EdgeInsets.all(2),
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
                                                  fontWeight: FontWeight.bold),
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
                                      SizedBox(
                                          height: 45,
                                          width: 150,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13.0),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.red))),
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
    final String? locality = placeMark.locality;
    streetAddress = placeMark.street;

    final String? postalCode = placeMark.postalCode;
    final String? country = placeMark.country;
    address = '$name, $locality, $postalCode, $country';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', address);
  }
}
