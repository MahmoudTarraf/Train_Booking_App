import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Email extends StatelessWidget {
  final Function emailHandler;
  Email({super.key, required this.emailHandler});
  String _email = '';
  Widget _checkEmail() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email must\'nt be empty!';
          }
          if (!value.contains('@')) {
            return 'This is not a valid Email';
          }
          return null;
        },
        onSaved: (value) {
          _email = value as String;
          emailHandler(_email);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Email',
          label: Text(
            'Enter Email',
            style: TextStyle(fontSize: 22),
          ),
          hintStyle: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _checkEmail();
  }
}
