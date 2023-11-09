import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TrainName extends StatelessWidget {
  final Function trainHandler;
  TrainName({super.key, required this.trainHandler});
  String _trainName = '';
  Widget _checkTrainName() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Train name must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          _trainName = value as String;
          trainHandler(_trainName);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.train),
          hintText: 'Train Name',
          hintStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _checkTrainName();
  }
}
