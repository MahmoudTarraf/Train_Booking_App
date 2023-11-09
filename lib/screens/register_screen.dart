import 'dart:async';
import '../data/list_of_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../user_authentication/phone_number.dart';
import '../user_authentication/date_picker.dart';
import '../user_authentication/password.dart';
import '../user_authentication/first_name.dart';
import '../user_authentication/last_name.dart';
import '../user_authentication/gender.dart';
import '../user_authentication/email.dart';
import './log_in_screen.dart';
import 'package:provider/provider.dart';
import '../data/auth.dart';
import '../widgets/electronic_wallet.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static const routeName = '/register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  String _gender = '';
  String _birthday = '1/1/2000';
  String _email = '';
  String _eWallet = '';
  void setFirstName(String firstName) {
    _firstName = firstName;
    //print(_firstName);
  }

  void setPasswordHandler(String password) {
    _password = password;
    //print(_password);
  }

  void setLastName(String lastName) {
    _lastName = lastName;
    //print(_lastName);
  }

  void setPhoneNumber(String phone) {
    _phoneNumber = phone;
    //print(_phoneNumber);
  }

  void setEWallet(String ewallet) {
    _eWallet = ewallet;
    //print(_phoneNumber);
  }

  void setEmail(String email) {
    _email = email;
    //print(_phoneNumber);
  }

  void setGender(String gender) {
    _gender = gender;
  }

  void setBirthday(String birthday) {
    _birthday = birthday;
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

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .signUp(
        email: _email.trim(),
        birthday: _birthday.trim(),
        firstName: _firstName.trim(),
        lastName: _lastName.trim(),
        password: _password.trim(),
        gender: _gender.trim(),
        phoneNumber: _phoneNumber.trim(),
        eWallet: _eWallet.trim(),
        context: context,
      )
          .then((value) async {
        Provider.of<ListOfUsersx>(context, listen: false).addUser(
          birthday: _birthday,
          eWallet: _eWallet,
          email: _email,
          firstName: _firstName,
          gender: _gender,
          lastName: _lastName,
          password: _password,
          phoneNumber: _phoneNumber,
        );

        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacementNamed(AuthChecker.routeName);
      });
    } on FirebaseAuthException catch (error) {
      var message = 'An error occurred, please check your credentials!';
      if (error.message != null) {
        message = error.message!;
      }
      _showErrorDialog(message);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      _showErrorDialog(error.toString());

      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _iconButton() {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: register,
        child: const Text(
          'Register',
          style: TextStyle(fontSize: 25),
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
              'assets/images/back2.jpeg',
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        textAlign: TextAlign.start,
                        'Register Now !',
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
                        ' Register now to book your best trips !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      FirstName(firstNameHandler: setFirstName),
                      const SizedBox(
                        height: 20,
                      ),
                      LastName(lastNameHandler: setLastName),
                      const SizedBox(
                        height: 20,
                      ),
                      Gender(genderHandler: setGender),
                      const SizedBox(
                        height: 20,
                      ),
                      DatePicker(dateHandler: setBirthday),
                      const SizedBox(
                        height: 20,
                      ),
                      Email(emailHandler: setEmail),
                      const SizedBox(
                        height: 20,
                      ),
                      PhoneNumber(phoneHandler: setPhoneNumber),
                      const SizedBox(
                        height: 20,
                      ),
                      ElectronicWallet(eWalletHandler: setEWallet),
                      const SizedBox(
                        height: 20,
                      ),
                      Password(setPasswordHandler2: setPasswordHandler),
                      const SizedBox(height: 20),
                      _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.red,
                            )
                          : _iconButton(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: const Text(
                              'Already have an account ? ',
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
                              Navigator.of(context).pushNamed(LogIn.routeName);
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 20,
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
