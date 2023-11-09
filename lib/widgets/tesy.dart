// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../screens/google_auth_api.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  var offer = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> makeAnOffer(
      int trainNumber, int offer, BuildContext context) async {
    double finalPrice = 2000 - (2000 * offer / 100);
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure You Want To Make This Offer?"),
          content: const Text("This Action Cant Be Undone."),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ).then((value) async {
      if (value == true) {
        final user = await GoogleAuthApi.signIn();
        if (user == null) return;
        final email = user.email;
        final auth = await user.authentication;
        final token = auth.accessToken!;
        GoogleAuthApi.signOut();
        final smtpServer = gmailSaslXoauth2(email, token);
        final message = Message()
          ..from = Address(email, 'Travel Agency')
          ..recipients = ['mahmoudtarraf77@gmail.com']
          ..subject = 'Ticket Offer'
          ..text =
              'Don\'t miss the new offer on train number$trainNumber for $offer% ,the new price is:$finalPrice!';
        try {
          await send(message, smtpServer);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Offer Made Successfully Nigga',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.teal,
                ),
              ),
              duration: Duration(seconds: 3),
            ),
          );
        } on MailerException {
          rethrow;
        }
      }
    });
  }

  // ignore: unused_element
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Make An Offer:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              int x = int.parse(value!);
                              setState(() {
                                offer = x;
                              });
                              if (value.isEmpty) {
                                return 'Offer  must\'nt be empty!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              String temp = value as String;
                              offer = int.parse(temp);
                              setState(() {
                                offer = int.parse(temp);
                              });
                              // setState(() {
                              //   offer = int.parse(temp);
                              // });
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.numbers),
                              hintText: 'Enter Offer Amount Percent',
                              hintStyle: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        onPressed: () {
                          makeAnOffer(3, offer, context);
                        },
                        child: const Text(
                          'Send',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
