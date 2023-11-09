import 'package:flutter/material.dart';
import 'log_in_screen.dart';
import './register_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const routeName = '/main_screen';

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Image(
        width: double.infinity,
        image: AssetImage('assets/images/new_train.png'),
        height: double.infinity,
        fit: BoxFit.cover,
      ),
      Positioned(
        top: 100,
        left: 28,
        child: Image.asset(
          'assets/images/new_train2.png',
          width: 350,
          fit: BoxFit.fitWidth,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
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
        body: Column(
          children: [
            const SizedBox(
              height: 300,
            ),
            const Text(
              ' Book now and explore the best \n offers !',
              style: TextStyle(fontSize: 23, color: Colors.white),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LogIn.routeName);
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Register.routeName);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.yellow,
                        Colors.amber,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
