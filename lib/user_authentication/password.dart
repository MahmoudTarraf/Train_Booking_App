// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({
    super.key,
    required this.setPasswordHandler2,
  });

  @override
  State<Password> createState() => _PasswordState();
  final Function setPasswordHandler2;
}

class _PasswordState extends State<Password> {
  String _passWord = '';
  String _passWords = '';
  bool showPass2 = true;
  String enterPasswordAgain = '';
  String enterPasswordAgains = '';
  bool showPass = true;
  Widget _enterPassword() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        obscureText: showPass,
        validator: (value) {
          _passWords = value as String;
          if (_passWords.isEmpty) {
            return 'Password must\'nt be empty!';
          }
          if (_passWords.length < 6) {
            return 'Password is too weak!';
          }
          return null;
        },
        onSaved: (value) {
          _passWord = _passWords;
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPass = !showPass;
              });
            },
            icon: showPass
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
          ),
          icon: const Icon(Icons.lock),
          hintText: 'Enter Password',
          hintStyle: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  Widget _reEnterPassword() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        obscureText: showPass2,
        validator: (value) {
          enterPasswordAgains = value as String;
          if (enterPasswordAgains.isEmpty) {
            return 'Password must\'nt be empty!';
          }
          if (enterPasswordAgains != _passWords) {
            return 'This password doesn\'t match the previous one !';
          }
          if (enterPasswordAgains.length < 6) {
            return 'Password is too weak!';
          }
          return null;
        },
        onSaved: (value) {
          enterPasswordAgain = enterPasswordAgains;
          widget.setPasswordHandler2(
            enterPasswordAgain,
          );
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPass2 = !showPass2;
              });
            },
            icon: showPass2
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
          ),
          icon: const Icon(Icons.lock),
          hintText: 'Enter Password Again',
          hintStyle: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _enterPassword(),
        const SizedBox(
          height: 20,
        ),
        _reEnterPassword(),
      ],
    );
  }
}
