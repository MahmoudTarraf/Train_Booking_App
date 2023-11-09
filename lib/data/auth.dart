// ignore_for_file: use_build_context_synchronously, deprecated_member_use, duplicate_ignore

import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/list_of_users.dart';
import '../screens/tabs_screen.dart';
import 'package:provider/provider.dart';

import '../screens/admin_screen.dart';

class Auth with ChangeNotifier {
  // List userBalance = [];
  int userBalance = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  bool get isAuth {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      return true;
    } else {
      return false;
    }
  }

  User? get user {
    return _user;
  }

  Future<Map<String, dynamic>> getUserData() async {
    final userId = _auth.currentUser?.uid;
    final url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/users/$userId.json';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } else {
      throw Exception('Failed to get user data: ${response.statusCode}');
    }
  }

  Future signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String gender,
    required String birthday,
    required String eWallet,
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      // Create user with email and password

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.toString(), context);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signIn({
    required String email,
    required String password,
    required bool isAdmin,
    required BuildContext context,
  }) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    try {
      if (isAdmin) {
        final String adminId =
            Provider.of<ListOfUsersx>(context, listen: false).adminId;

        final url =
            'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/admins/$adminId.json';
        try {
          final response = await http.get(Uri.parse(url));

          if (response.statusCode == 200) {
            final selectedData =
                json.decode(response.body) as Map<String, dynamic>?;

            if (selectedData != null) {
              if (selectedData['Email'].toString().toLowerCase().trim() ==
                  email.toString().toLowerCase().trim()) {
                await Navigator.pushReplacementNamed(
                    context, AdminScreen.routeName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                    content: Text(
                      'Not An Admin...Nice Try though!',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),
                );
              }
            }
          } else if (response.statusCode == 404) {
            throw 'error';
          }
          notifyListeners();
        } catch (error) {
          rethrow;
        }
      } else {
        await Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
        _user = userCredential.user;

        notifyListeners();
      }

      return false;
    } on FirebaseAuthException catch (e) {
      var message = 'Could Not Auhenticate You,Try Again Later!';
      if (e.code == 'user-not-found') {
        message = 'User not found';
        _showErrorDialog(message, context);
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password';
        _showErrorDialog(message, context);
      } else if (e.code == 'not-verified') {
        message = 'user not verified';
        _showErrorDialog(message, context);
      } else {
        message = e.code.toString();
        _showErrorDialog(message, context);
      }
    } catch (e) {
      _showErrorDialog(e.toString(), context);
    }
  }

  void _showErrorDialog(String message, BuildContext context) {
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

  Future<void> updateUserWallet(String eWallet) async {
    final userId = _auth.currentUser?.uid;

    final url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/users/$userId.json';
    try {
      await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'Electronic Wallet': eWallet,
          },
        ),
      );

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> chargeUserBalance(String ewalletNumber, int newBalance) async {
    final url = Uri.parse(
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/users.json');

    // Send GET request to retrieve user data
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;

    // Find user with matching e-wallet number
    String? userId;
    data.forEach((key, value) {
      if (value['Electronic Wallet'] == ewalletNumber) {
        userId = key;
      }
    });

    if (userId == null) {
      throw Exception('User with e-wallet number $ewalletNumber not found');
    }

    // Send PATCH request to update user's balance
    final result = newBalance + userBalance;
    final updateUrl = Uri.parse(
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/users/$userId.json');
    final updateBody = json.encode({'Balance': result});
    final updateResponse = await http.patch(updateUrl, body: updateBody);

    if (updateResponse.statusCode != 200) {
      throw Exception('Failed to update balance for user $userId');
    }
  }

  Future<void> updateUserBalance(int seats, int balance, int tripPrice) async {
    final userId = _auth.currentUser?.uid;
    final thisBalance = balance - (tripPrice * seats);
    final url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/users/$userId.json';
    try {
      await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'Balance': thisBalance,
          },
        ),
      );

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();

    _user = null;
    notifyListeners();
  }

  Future<bool> tryAutoLogIn() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      _user = currentUser;

      setAutoLogout();

      return true;
    } else {
      return false;
    }
  }

  void setAutoLogout() {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      final expiryTime =
          currentUser.metadata.creationTime!.add(const Duration(hours: 1));
      final timeToExpiry = expiryTime.difference(DateTime.now()).inSeconds;
      Timer(Duration(seconds: timeToExpiry), signOut);
    }
  }

  void setBalance(int x) {
    userBalance = x;
    notifyListeners();
  }
}
