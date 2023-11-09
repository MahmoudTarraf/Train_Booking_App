import 'package:flutter/material.dart';

class TripType extends StatefulWidget {
  const TripType({required this.searchHandler, super.key});
  final Function searchHandler;

  @override
  State<TripType> createState() => _TripTypeState();
}

class _TripTypeState extends State<TripType> {
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

  String _selectedCountry = '';

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
