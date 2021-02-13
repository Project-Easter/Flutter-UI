import 'package:flutter/material.dart';

class ExploreNearby extends StatefulWidget {
  @override
  _ExploreNearbyState createState() => _ExploreNearbyState();
}

class _ExploreNearbyState extends State<ExploreNearby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Explore Nearby'),
      ),
      body: Center(
        child: Text('Explore Nearby Screen'),
      ),
    );
  }
}
