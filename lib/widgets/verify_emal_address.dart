// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/list_of_users.dart';
import '../screens/log_in_screen.dart';
import 'package:provider/provider.dart';

class VerifyEmailAddress extends StatefulWidget {
  const VerifyEmailAddress({super.key});

  @override
  State<VerifyEmailAddress> createState() => _VerifyEmailAddressState();
}

class _VerifyEmailAddressState extends State<VerifyEmailAddress> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    if (mounted) {
      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      });
    }

    if (isEmailVerified) {
      await Provider.of<ListOfUsersx>(context, listen: false)
          .createUserFireBase();

      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(
        const Duration(seconds: 5),
      );
      setState(() {
        canResendEmail = true;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('something went wrong!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const LogIn()
      : Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Verify',
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
                    'Email',
                    style: TextStyle(
                      color: Color.fromARGB(255, 163, 31, 22),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'A Verification Email Has Been           Sent To Your Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: canResendEmail ? sendVerificationEmail : null,
                  icon: const Icon(
                    Icons.email,
                    size: 32,
                  ),
                  label: const Text(
                    'Resend Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        );
}
