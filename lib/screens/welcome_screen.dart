import 'package:flutter/material.dart';
import '/screens/privecy_screen.dart';
import './main_screen.dart';

class Welcome extends StatelessWidget {
  static const routeName = '/welcome';
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      title: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                appBar.preferredSize.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/travel.jpeg',
                ),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 85,
                  left: 80,
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(MainScreen.routeName);
                      },
                      child: const Text(
                        'START NOW !',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                /*Positioned(
                  top: 180,
                  left: 120,
                  child: Container(
                    child: Text(
                      'WELCOME',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Anton',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),*/
                Positioned(
                  left: 120,
                  bottom: 20,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(PrivecyScreen.routeName);
                    },
                    child: const Text(
                      'Privecy and Policy ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
