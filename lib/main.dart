import './data/list_of_users.dart';
import './screens/admin_screen.dart';
import './screens/charge_balance.dart';
import './screens/chatpot_screen.dart';
import './screens/final_offer_screen.dart';
import './screens/offer_screen.dart';
import './widgets/verify_emal_address.dart';

import './screens/user_tickets_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/delete_train_screen.dart';
import '/data/train_dummy.dart';
import '/screens/search_for_train_screen.dart';
import '/screens/special_log_in.dart';
import './screens/main_screen.dart';
import 'screens/log_in_screen.dart';
import 'screens/register_screen.dart';
import './screens/welcome_screen.dart';
import './screens/privecy_screen.dart';
import './screens/profile_screen.dart';
import 'screens/splash_screen.dart';

import './screens/tabs_screen.dart';
import 'screens/train_details.dart';
import './screens/search_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/add_train_screen.dart';
import 'screens/ticket_screen.dart';
import 'package:provider/provider.dart';
import './data/auth.dart';
import 'screens/update_train_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './widgets/settings.dart';
import './widgets/the_final_map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAtb1bwZifAM1XysuBydmUQSh2juK78lTU',
      appId: '1:631909662774:android:0d69af77397d2c88b55897',
      messagingSenderId: '631909662774',
      projectId: 'mahmoudproject-2ded7',
    ),
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ListOfUsersx(),
          ),
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider(
            create: (context) => TrainDummy(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              platform: TargetPlatform.android,
              textTheme: ThemeData.light().textTheme.copyWith(
                  headlineSmall: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                  ),
                  bodyMedium: const TextStyle(
                    fontSize: 24,
                    // fontFamily: 'Lato',
                  )),
              appBarTheme: const AppBarTheme(
                color: Colors.teal,
              ),
              primarySwatch: Colors.teal,
            ),
            home: const AuthChecker(),
            routes: {
              FinalOfferScreen.routeName: (context) => FinalOfferScreen(),
              OfferScreen.routeName: (context) => const OfferScreen(),
              LogIn.routeName: (context) => const LogIn(),
              Register.routeName: (context) => const Register(),
              MainScreen.routeName: (context) => const MainScreen(),
              PrivecyScreen.routeName: (context) => const PrivecyScreen(),
              ProfileScreen.routeName: (context) => const ProfileScreen(),
              TrainDetails.routeName: (context) => const TrainDetails(),
              SearchScreen.routeName: (context) => const SearchScreen(),
              TabsScreen.routeName: (context) => const TabsScreen(),
              PaymentScreen.routeName: (context) => const PaymentScreen(),
              SpecialLogInScreen.routeName: (context) =>
                  const SpecialLogInScreen(),
              AddTrainScreen.routeName: (context) => AddTrainScreen(),
              TicketScreen.routeName: (context) => const TicketScreen(),
              UpdateTrainScreen.routeName: (context) => UpdateTrainScreen(),
              SearchForTrainScreen.routeName: (context) =>
                  const SearchForTrainScreen(),
              DeleteTrainScreen.routeName: (context) =>
                  const DeleteTrainScreen(),
              Settings.routeName: (context) => const Settings(),
              UserTicketsScreen.routeName: (context) =>
                  const UserTicketsScreen(),
              TheFinalMap.routeName: (context) => const TheFinalMap(),
              Welcome.routeName: (context) => const Welcome(),
              AdminScreen.routeName: (context) => const AdminScreen(),
              MyBotpressChatScreen.routeName: (context) =>
                  const MyBotpressChatScreen(),
              ChargeBalanceScreen.routeName: (context) =>
                  const ChargeBalanceScreen(),
              AuthChecker.routeName: (context) => const AuthChecker(),
            }));
    // ));
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});
  static const routeName = '/auth_checker';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return const VerifyEmailAddress();
          } else if (snapShot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapShot.hasError) {
            return Builder(builder: (context) {
              return const Center(
                child: Text(
                  'Something Went Wrong!',
                  style: TextStyle(fontSize: 22),
                ),
              );
            });
          } else {
            return const Welcome();
          }
        },
      ),
    );
  }
}
