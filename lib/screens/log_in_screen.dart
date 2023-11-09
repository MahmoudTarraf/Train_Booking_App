// ignore_for_file: unused_field

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';

import '../user_authentication/email.dart';
import 'package:provider/provider.dart';
import '../data/auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});
  static const routeName = '/log_in';

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isAdmin = false;

  void _toggleIsAdmin(bool value) {
    setState(() {
      _isAdmin = value;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _passWord = '';
  String _email = '';

  void setEmail(String email) {
    _email = email;
    //print(_phoneNumber);
  }

  void setPassword(String pass) {
    _passWord = pass;
    //print(_passWord);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'An Error Occured!',
          style: TextStyle(fontSize: 23),
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 23),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'Okay',
              style: TextStyle(
                fontSize: 23,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isLoading = false;
  Future<void> logIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
          'Logging In...',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
    setState(() {
      _isLoading = true;
    });
    try {
      // Check if user exists for the given email
      final signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(_email);
      if (signInMethods.isNotEmpty) {
        // User exists, log in

        // ignore: use_build_context_synchronously
        await Provider.of<Auth>(context, listen: false).signIn(
            context: context,
            email: _email,
            password: _passWord,
            isAdmin: _isAdmin);

        // ignore: use_build_context_synchronously
      } else {
        // User does not exist, show error message
        _showErrorDialog('No Users Found For That Email!');
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An error occurred, please check your credentials!';
      if (error.message != null) {
        message = error.message!;
      }
      _showErrorDialog(message);
    } catch (error) {
      var message = 'Could not authenticate you. Please try again later.';
      if (error.toString().contains('No user found for that email')) {
        message =
            'No user found for that email. Please check your email address.';
      }
      _showErrorDialog(message);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget _iconButton() {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: logIn,
        child: const Text(
          'LOGIN',
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
              'assets/images/back5.jpeg',
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
                        'Login to your account',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Alton',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Login now and see what\'s NEW !',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Email(emailHandler: setEmail),
                      const SizedBox(
                        height: 20,
                      ),
                      ThisPassword(passwordHandler: setPassword),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Are You An Admin?',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 25,
                            ),
                          ),
                          Checkbox(
                            hoverColor: Colors.amber,
                            fillColor:
                                const MaterialStatePropertyAll(Colors.white),
                            checkColor: Colors.red,
                            value: _isAdmin,
                            onChanged: (value) => _toggleIsAdmin(value!),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            )
                          : _iconButton(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            child: const Text(
                              'Don\'t have an account ? ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Register.routeName);
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Register.routeName);
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
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
  const ThisPassword({required this.passwordHandler, super.key});
  final Function passwordHandler;

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
          widget.passwordHandler(_passWord);
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
            hintStyle: const TextStyle(fontSize: 22)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterPassword();
  }
}
