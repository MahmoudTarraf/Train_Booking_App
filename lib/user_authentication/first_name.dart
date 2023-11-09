import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class FirstName extends StatelessWidget {
  final Function firstNameHandler;
  FirstName({super.key, required this.firstNameHandler});
  String _firstName = '';
  Widget _checkFirstName() {
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
            return 'First name must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          _firstName = value as String;
          firstNameHandler(_firstName);
        },
        decoration: const InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'First name',
            hintStyle: TextStyle(fontSize: 22)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _checkFirstName();
  }
}
