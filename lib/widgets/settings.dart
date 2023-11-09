import 'package:flutter/material.dart';
import '../screens/chatpot_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/user_tickets_screen.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';
  const Settings({super.key});

  Widget buildListTile(
      {required Icon icon,
      required String title,
      required BuildContext ctx,
      required screen}) {
    return Row(children: [
      IconButton(
        iconSize: 40,
        color: Theme.of(ctx).primaryColor,
        onPressed: () {
          Navigator.of(ctx).pushNamed(screen);
        },
        icon: icon,
      ),
      TextButton(
        onPressed: () {
          Navigator.of(ctx).pushNamed(screen);
        },
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/profile_pic2.jpg'),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  buildListTile(
                    ctx: context,
                    icon: const Icon(
                      Icons.screen_share,
                    ),
                    title: 'Main Screen',
                    screen: TabsScreen.routeName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildListTile(
                    ctx: context,
                    icon: const Icon(
                      Icons.airplane_ticket,
                    ),
                    title: 'My Tickets',
                    screen: UserTicketsScreen.routeName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildListTile(
                    ctx: context,
                    icon: const Icon(
                      Icons.person,
                    ),
                    title: 'Profile',
                    screen: ProfileScreen.routeName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildListTile(
                    ctx: context,
                    icon: const Icon(
                      Icons.chat,
                    ),
                    title: 'Chat With Bot',
                    screen: MyBotpressChatScreen.routeName,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
