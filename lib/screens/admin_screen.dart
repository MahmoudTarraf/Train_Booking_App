// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../data/auth.dart';
import '../screens/charge_balance.dart';
import '../screens/offer_screen.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import './add_train_screen.dart';
import './search_for_train_screen.dart';
import './delete_train_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});
  static const routeName = '/admin_screen';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Image.asset(
              'assets/images/back5.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Select an action to perform:',
                    style: TextStyle(fontSize: 24, color: Colors.yellow),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(15),
                      isExpanded: true,
                      underline: Container(),
                      alignment: Alignment.center,
                      value: 'Add A Train',
                      onChanged: (String? newValue) {
                        if (newValue == 'Add A Train') {
                          Navigator.of(context)
                              .pushNamed(AddTrainScreen.routeName);
                        } else if (newValue == 'Update A Train') {
                          Navigator.of(context)
                              .pushNamed(SearchForTrainScreen.routeName);
                        } else if (newValue == 'Delete A Train') {
                          Navigator.of(context)
                              .pushNamed(DeleteTrainScreen.routeName);
                        } else if (newValue == 'Charge Balance') {
                          Navigator.of(context)
                              .pushNamed(ChargeBalanceScreen.routeName);
                        } else if (newValue == 'Add An Offer') {
                          Navigator.of(context)
                              .pushNamed(OfferScreen.routeName);
                        }
                      },
                      items: <String>[
                        'Add A Train',
                        'Update A Train',
                        'Delete A Train',
                        'Charge Balance',
                        'Add An Offer',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          alignment: Alignment.center,
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              top: 50,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await Provider.of<Auth>(context, listen: false).signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AuthChecker.routeName, (route) => false);
                    },
                    child: const Text(
                      'LogOut',
                      style: TextStyle(fontSize: 24, color: Colors.red),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await Provider.of<Auth>(context, listen: false).signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AuthChecker.routeName, (route) => false);
                    },
                    icon: const Icon(Icons.logout_outlined),
                    color: Colors.red,
                  )
                ],
              ),
            )
          ]),
        ));
  }
}
