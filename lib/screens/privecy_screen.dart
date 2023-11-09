// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import './main_screen.dart';

class PrivecyScreen extends StatefulWidget {
  const PrivecyScreen({super.key});
  static const routeName = '/privecy_screen';

  @override
  State<PrivecyScreen> createState() => _PrivecyScreenState();
}

class _PrivecyScreenState extends State<PrivecyScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  final _policy1 =
      'You are going to be required to enter your personal information such as :';

  final _policy2 =
      '\nYour information are totally confidintial and is for security purposes only, you can check your info in the Profile section!';

  final _info =
      '1_Email.\n2_Phone Number.\n3_Your first and last name.\n4_Birthday.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 236, 202),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Privecy and Policy',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/back5.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _policy1,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _info,
                  style: const TextStyle(fontSize: 26, color: Colors.amber),
                ),
                Text(
                  _policy2,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 50,
                  width: 220,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, MainScreen.routeName);
                    },
                    child: const Text(
                      'Go to Home Page !',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
