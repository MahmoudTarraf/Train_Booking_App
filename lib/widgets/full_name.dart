import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class FullName extends StatelessWidget {
  List<String> nameList = [];
  final Function dullNameHandler;
  FullName({super.key, required this.dullNameHandler});
  String _fullName = '';
  Widget _checkFullName() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
        ],
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'name must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          _fullName = value as String;
          nameList.add(_fullName);
          dullNameHandler(nameList);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Enter Full Name',
          label: Text(
            'Full Name',
            style: TextStyle(fontSize: 20),
          ),
          hintStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _checkFullName();
  }
}
