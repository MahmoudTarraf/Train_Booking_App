import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ListOfStops extends StatelessWidget {
  final Function listOfStops;
  ListOfStops({super.key, required this.listOfStops});
  String _listOfStops = '';
  Widget _checkListOfStops() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This List must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          _listOfStops = value as String;
          listOfStops(_listOfStops);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Stops List',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _checkListOfStops();
  }
}
