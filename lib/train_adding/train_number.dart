import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TrainNumber extends StatelessWidget {
  final Function trainHandler;
  TrainNumber({super.key, required this.trainHandler});
  String _trainNumber = '';
  Widget _enterTrainNumber(BuildContext context) {
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
            return 'Train number must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          _trainNumber = value as String;
          int temp = int.parse(_trainNumber);
          trainHandler(temp);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.numbers),
          hintText: 'Train Number',
          hintStyle: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterTrainNumber(context);
  }
}
