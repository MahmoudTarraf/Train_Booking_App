import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyMap extends StatefulWidget {
  const MyMap({
    super.key,
  });

  static const routeName = '/mymap';

  @override
  MyMapState createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  static const routeName = '/mymap';

  @override
  void initState() {
    _getPolylineCoordinates();
    super.initState();
  }

  final String apiKey =
      "5b3ce3597851110001cf62481722697de4ea41659d44f01f6feb8fac";
  final String endpoint =
      "https://api.openrouteservice.org/v2/directions/driving-car/json?";
  final String start = "8.681495,49.41461";
  final String end = "8.687872,49.420318";

  final MapController _mapController = MapController();
  List<LatLng> _polylineCoordinates = [];
  Future<void> _getPolylineCoordinates() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf62481722697de4ea41659d44f01f6feb8fac&start=8.681495,49.41461&end=8.687872,49.420318'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final polylineString = data['features'][0]['geometry'].toString();
        final polylinePoints = PolylinePoints();
        final result = polylinePoints.decodePolyline(polylineString);
        setState(() {
          _polylineCoordinates = result
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();
        });

        // Check that the polyline coordinates list is not empty
        if (_polylineCoordinates.isNotEmpty) {
          _mapController.fitBounds(
            LatLngBounds.fromPoints(_polylineCoordinates),
            options: const FitBoundsOptions(
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
            ),
          );

          // Check that the polyline coordinates list has at least one element
          if (_polylineCoordinates.isNotEmpty) {
            // Access the first element of the list
            //print(_polylineCoordinates[0]);

            // Access the last element of the list
            //print(_polylineCoordinates[_polylineCoordinates.length - 1]);
          }
        }
      } else if (response.statusCode == 401) {
        throw Exception(
            "Failed to authenticate API key, status code: ${response.statusCode}");
      } else {
        throw Exception(
            "Failed to fetch routing data, status code: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text('ajsdg'),
          /*FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(35.5122, 35.7909),
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _polylineCoordinates,
                    color: Colors.red,
                    strokeWidth: 3.0,
                  ),
                ],
              ),
            ],
          ),*/
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _getPolylineCoordinates,
        child: Icon(Icons.directions),
      ),*/
    );
  }
}
