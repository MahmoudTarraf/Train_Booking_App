// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../data/auth.dart';
// import '../screens/tabs_screen.dart';
// import '../screens/profile_screen.dart';

// class MainDrawer extends StatelessWidget {
//   const MainDrawer({super.key});
//   Widget buildListTile(
//     String title,
//     IconData icon,
//     Function tabHandler,
//   ) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         size: 50,
//         color: Colors.amber,
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(
//           color: Colors.white,
//           fontStyle: FontStyle.normal,
//           fontSize: 26,
//         ),
//       ),
//       onTap: () => tabHandler(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           color: Colors.amber.shade400,
//           height: 100,
//           width: double.infinity,
//           padding: const EdgeInsets.all(20),
//           alignment: Alignment.centerLeft,
//           child: const Text(
//             'Settings',
//             style: TextStyle(
//               fontSize: 35,
//               fontFamily: 'RobotoCondensed',
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         buildListTile(
//           'Trains',
//           Icons.train_outlined,
//           () {
//             Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
//           },
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         buildListTile(
//           'My Profile',
//           Icons.person_pin_circle_outlined,
//           () {
//             Navigator.of(context).pushNamed(
//               ProfileScreen.routeName,
//             );
//           },
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         ListTile(
//           leading: const Icon(
//             Icons.exit_to_app,
//             size: 50,
//             color: Colors.amber,
//           ),
//           title: const Text(
//             'Log Out',
//             style: TextStyle(
//               color: Colors.white,
//               fontStyle: FontStyle.normal,
//               fontSize: 26,
//             ),
//           ),
//           onTap: () {
//             Navigator.of(context).pop();
//             Provider.of<Auth>(context, listen: false).signOut();
//           },
//         ),
//       ],
//     );
//   }
// }
