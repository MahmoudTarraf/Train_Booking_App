// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class ListOfUsersx with ChangeNotifier {
  List<TheUser> listOfUsers = [];
  final String adminId = 'HCzVtjB7xJbkGD5oVYl8i6miLen1';
  List<TheUser> get userList {
    // ignore: recursive_getters
    return [...listOfUsers];
  }

  void addUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String eWallet,
    required String gender,
    required String phoneNumber,
    required String birthday,
  }) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userId = auth.currentUser?.uid;
    listOfUsers.add(
      TheUser(
        eWallet: eWallet,
        email: email,
        balance: 0,
        id: userId,
        birthday: birthday,
        firstName: firstName,
        gender: gender,
        lastName: lastName,
        pasWord: password,
        phoneNumber: phoneNumber,
      ),
    );
  }

  Future createUserFireBase() async {
    final TheUser thisUser = userList.last;
    final user = FirebaseAuth.instance.currentUser!;
    try {
      final userRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');
      userRef.set({
        'User Id': user.uid,
        'Email': thisUser.email,
        'First name': thisUser.firstName,
        'Last name': thisUser.lastName,
        'Gender': thisUser.gender,
        'Phone Number': thisUser.phoneNumber,
        'Password': thisUser.pasWord,
        'Birthday': thisUser.birthday,
        'Electronic Wallet': thisUser.eWallet,
        'Balance': 0,
      });
    } catch (error) {
      rethrow;
    }
  }
}
