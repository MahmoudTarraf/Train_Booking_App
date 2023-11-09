// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'add_train_screen.dart';

import '../widgets/full_name.dart';

class SpecialLogInScreen extends StatefulWidget {
  const SpecialLogInScreen({super.key});
  static const routeName = '/special_log_in';

  @override
  State<SpecialLogInScreen> createState() => _SpecialLogInScreenState();
}

class _SpecialLogInScreenState extends State<SpecialLogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _passWord = '';
  String _name = '';
  void setFullName(String name) {
    _name = name;
  }

  void setPassword(String pass) {
    _passWord = pass;
  }

  Widget _iconButton() {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          _formKey.currentState!.save();
          Navigator.of(context).pushNamed(AddTrainScreen.routeName);
        },
        child: const Text(
          'SPECIAL LOGIN',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'TRAVEL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'AGENCY',
              style: TextStyle(
                color: Color.fromARGB(255, 163, 31, 22),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/back6.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Login As An Admin !',
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Alton',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        ' Login now And Add Trips !',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      FullName(dullNameHandler: setFullName),
                      const SizedBox(
                        height: 20,
                      ),
                      const ThisPassword(),
                      const SizedBox(height: 25),
                      _iconButton(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThisPassword extends StatefulWidget {
  const ThisPassword({super.key});

  @override
  State<ThisPassword> createState() => _ThisPasswordState();
}

class _ThisPasswordState extends State<ThisPassword> {
  String _passWord = '';
  String _passWords = '';
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
          hintStyle: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterPassword();
  }
}
