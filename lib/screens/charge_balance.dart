import 'package:flutter/material.dart';
import '../data/auth.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChargeBalanceScreen extends StatefulWidget {
  static const routeName = '/charge_balance.dart';

  //final Function trainHandler;
  const ChargeBalanceScreen({
    super.key,
  });

  @override
  State<ChargeBalanceScreen> createState() => _ChargeBalanceScreenState();
}

class _ChargeBalanceScreenState extends State<ChargeBalanceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _balance = 0;
  String _eWallet = '';
  Future<void> chargeBalance(String eWallet, int balance) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure You Want To Charge Balance?"),
          content: const Text("This Action Cant Be Undone."),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        Provider.of<Auth>(context, listen: false)
            .chargeUserBalance(eWallet, balance)
            .catchError((error) {
          showDialog(
              context: context,
              builder: ((ctx) {
                return AlertDialog(
                  title: const Text(
                    'An Error Occured!',
                  ),
                  content: const Text('Something Went Wrong'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Okay'),
                    ),
                  ],
                );
              }));
        });
      }
    });
  }

  Widget _enterEWallet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'E_Wallet number must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          String temp = value as String;
          _eWallet = temp;
          setEWallet(_eWallet);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.numbers),
          hintText: 'Enter E_Wallet Number',
          hintStyle: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _enterBalanceAmount(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Balance  must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          String temp = value as String;
          _balance = int.parse(temp);
          setBalance(_balance);
          // trainHandler(temp);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.numbers),
          hintText: 'Enter Balance Amount',
          hintStyle: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void setBalance(int balance) {
    _balance = balance;
  }

  void setEWallet(String eWallet) {
    _eWallet = eWallet;
  }

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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Charge Balance:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: _enterEWallet(context),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: _enterBalanceAmount(context),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            chargeBalance(_eWallet, _balance);
                          },
                          child: const Text(
                            'Charge',
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
