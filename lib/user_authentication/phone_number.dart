import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PhoneNumber extends StatelessWidget {
  final Function phoneHandler;
  PhoneNumber({super.key, required this.phoneHandler});
  String _phoneNumber = '';
  Widget _enterPhoneNumber(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLength: 10,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Phone number must\'nt be empty!';
          }
          if (value.length == 1) {
            return 'Phone Number must start with 09';
          }
          if (value.substring(0, 2) != '09') {
            return 'Phone Number must start with 09********';
          }

          if (value.length < 10) {
            return 'Phone Number must be 10 digits';
          }

          return null;
        },
        onSaved: (value) {
          _phoneNumber = value as String;
          phoneHandler(_phoneNumber);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.phone),
          hintText: 'Phone Number',
          hintStyle: TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterPhoneNumber(context);
  }
}
