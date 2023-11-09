import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class TheFinalMap extends StatefulWidget {
  const TheFinalMap({super.key});
  static const routeName = '/final_map.dart';

  @override
  State<TheFinalMap> createState() => _TheFinalMapState();
}

class _TheFinalMapState extends State<TheFinalMap> {
  final MapController _mapController = MapController();

  var _center = LatLng(35.5122, 35.7909);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    switch (args) {
      case 'Damascus':
        _center = LatLng(33.5138, 36.2765);
        break;
      case 'Aleppo':
        _center = LatLng(36.2021, 37.1343);
        break;
      case 'Latakia':
        _center = LatLng(35.5122, 35.7909);
        break;
      case 'Homs':
        _center = LatLng(34.7326, 36.7135);
        break;
      default:
        _center = _center;
        break;
    }
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _center,
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}
