import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StationName extends StatelessWidget {
  final Function stationHandler;
  StationName({super.key, required this.stationHandler});
  String _stationName = '';
  Widget _checkStationName() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Station Name must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          _stationName = value as String;
          stationHandler(_stationName);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.foundation_outlined),
          hintText: 'Station Name',
          hintStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _checkStationName();
  }
}
