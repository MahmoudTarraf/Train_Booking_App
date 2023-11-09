// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';

class MyBotpressChatScreen extends StatefulWidget {
  const MyBotpressChatScreen({super.key});

  @override
  _MyBotpressChatScreenState createState() => _MyBotpressChatScreenState();
  static const routeName = '/chatpot';
}

class _MyBotpressChatScreenState extends State<MyBotpressChatScreen> {
  @override
  Widget build(BuildContext context) {
    const url =
        'https://mediafiles.botpress.cloud/793d4a37-a7c8-4250-8dc5-dbdb9a0b387d/webchat/bot.html';
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          centerTitle: true,
          title:
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Chat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Bot',
              style: TextStyle(
                color: Color.fromARGB(255, 163, 31, 22),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
        body: const WebviewScaffold(
          url: url,
          withZoom: true,
          withLocalStorage: true,
          initialChild: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
