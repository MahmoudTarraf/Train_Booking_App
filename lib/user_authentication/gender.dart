import 'package:flutter/material.dart';

class Gender extends StatefulWidget {
  const Gender({super.key, required this.genderHandler});

  @override
  State<Gender> createState() => _GenderState();
  final Function genderHandler;
}

class _GenderState extends State<Gender> {
  String _gender = 'Male';
  @override
  void initState() {
    widget.genderHandler(_gender);
    super.initState();
  }

  Widget _chooseGender() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const Text(
        'Gender :',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButton<String>(
          underline: Container(),
          value: _gender,
          onChanged: (newValue) {
            widget.genderHandler(_gender);
            setState(() {
              _gender = newValue as String;

              widget.genderHandler(_gender);
            });
          },
          items: <String>['Male', 'Female']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(children: [
                value == 'Male'
                    ? const Icon(
                        Icons.man,
                        color: Colors.teal,
                      )
                    : const Icon(
                        Icons.woman,
                        color: Colors.teal,
                      ),
                const SizedBox(
                  height: 15,
                ),
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

  @override
  Widget build(BuildContext context) {
    return _chooseGender();
  }
}
