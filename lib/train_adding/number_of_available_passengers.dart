import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NumberOfAvailablePasssengers extends StatelessWidget {
  final Function passengersHandler;
  NumberOfAvailablePasssengers({super.key, required this.passengersHandler});
  String _numberOfAvailablePassengers = '';
  Widget _enterNumberOfAvailablePasssengers(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Passengers number must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          _numberOfAvailablePassengers = value as String;
          int temp = int.parse(_numberOfAvailablePassengers);
          passengersHandler(temp);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Number Of Available Passengers',
          hintStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterNumberOfAvailablePasssengers(context);
  }
}
