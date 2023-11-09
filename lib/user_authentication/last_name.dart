import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class LastName extends StatelessWidget {
  final Function lastNameHandler;
  LastName({super.key, required this.lastNameHandler});
  String _lastName = '';
  Widget _checkLastName() {
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
            return 'Last name must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          _lastName = value as String;
          lastNameHandler(_lastName);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Last name',
          hintStyle: TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _checkLastName();
  }
}
