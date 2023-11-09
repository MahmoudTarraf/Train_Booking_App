// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import 'package:thefinaltest/data/train_dummy.dart';
import 'package:thefinaltest/models/train.dart';
import 'package:thefinaltest/screens/google_auth_api.dart';
import 'package:thefinaltest/widgets/new_offer_widget.dart';

// ignore: must_be_immutable
class FinalOfferScreen extends StatelessWidget {
  static const routeName = '/offer_final_screen.dart';

  FinalOfferScreen({
    super.key,
  });

  int offer = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void setOfferAmount(int num) {
    offer = num;
  }

  Future<void> makeAnOffer(
      Train thisTrain, int offer, BuildContext context) async {
    double result = 2000 - (2000 * offer / 100);
    int finalPrice = result.round();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure You Want To Make This Offer?"),
          content: const Text("This Action Can't Be Undone."),
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
        if (thisTrain.trainNumber < 0 || finalPrice <= 0) {
          return;
        }
        try {
          await Provider.of<TrainDummy>(context, listen: false)
              .updateTrainTicketPrice(
            trainNumber: thisTrain.trainNumber,
            trainId: thisTrain.id,
            ticketPrice: finalPrice,
          );
          final user = await GoogleAuthApi.signIn();
          await Provider.of<TrainDummy>(context, listen: false).getUsersData();
          final emailList =
              Provider.of<TrainDummy>(context, listen: false).emailList;

          if (user == null) {
            return;
          }

          final email = user.email;
          final auth = await user.authentication;
          final token = auth.accessToken!;

          final smtpServer = gmailSaslXoauth2(email, token);
          final message = Message()
            ..from = Address(email, 'Travel Agency')
            ..recipients = emailList
            ..subject = 'Ticket Offer'
            ..text =
                'Don\'t miss the new offer on train number${thisTrain.trainNumber} for $offer% ,the new price is:$finalPrice!';
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
            //print(e);
            rethrow;
          }
        } catch (e) {
          //print(e);
          rethrow;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Train thisTrain = ModalRoute.of(context)!.settings.arguments == null
        ? Provider.of<TrainDummy>(context, listen: false).trainList[0]
        : ModalRoute.of(context)!.settings.arguments as Train;
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
                child: Form(
                  key: _formKey,
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
                      const SizedBox(
                        height: 30,
                      ),
                      OfferWidgetNew(trainHandler: setOfferAmount),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            makeAnOffer(thisTrain, offer, context);
                          },
                          child: const Text(
                            'Send To All Users',
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
            ),
          ],
        ),
      ),
    );
  }
}
