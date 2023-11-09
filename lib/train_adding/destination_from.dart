// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class DestinationFrom extends StatefulWidget {
  const DestinationFrom({required this.searchHandler, super.key});
  final Function searchHandler;

  @override
  State<DestinationFrom> createState() => _DestinationFromState();
}

class _DestinationFromState extends State<DestinationFrom> {
  final governorates = const [
    'Damascus',
    'Aleppo',
    'Latakia',
    'Homs',
    /*'Hama',
    'Rif_Dimashq',
    'Deir Ez_Zor',
    'Daraa',
    'Idlib',
    'Qunietra',
    'As_Suayda',
    'Homs',
    'Tartus',
    'Al_Hasakah',
    'Raqqa',*/
  ];

  var _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const Text(
        'Destination From:',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      Container(
        height: 40,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButton<String>(
          underline: Container(),
          borderRadius: BorderRadius.circular(15),
          value: _selectedCountry,
          onChanged: (newValue) {
            setState(() {
              _selectedCountry = newValue as String;
              widget.searchHandler(newValue);
            });
          },
          items: governorates.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(children: [
                const Icon(Icons.train),
                Text(
                  value,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              ]),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
