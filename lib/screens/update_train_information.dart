// import 'package:flutter/material.dart';
// import '../train_adding/train_name.dart';
// import '../train_adding/train_number.dart';
// import '../data/train_dummy.dart';

// // ignore: must_be_immutable
// class UpdateTrainInformationScreen extends StatelessWidget {
//   UpdateTrainInformationScreen({super.key});
//   static const routeName = '/update_train_information_screen.dart';
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 
//   //Train thisTrain=trainList;

//   Widget _iconButton(BuildContext context) {
//     return SizedBox(
//       width: 200,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: () {
//           if (!_formKey.currentState!.validate()) {
//             return;
//           }
//           _formKey.currentState!.save();

//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Confirm Updating"),
//                 content: Text("Are you sure you want to update this train?"),
//                 actions: [
//                   TextButton(
//                     child: Text("Cancel"),
//                     onPressed: () {
//                       Navigator.of(context).pop(false);
//                     },
//                   ),
//                   TextButton(
//                     child: Text("Update"),
//                     onPressed: () {
//                       Navigator.of(context).pop(true);
//                     },
//                   ),
//                 ],
//               );
//             },
//           ).then((value) {
//             if (value == true) {
//               // User confirmed the edit, do something here
//               updateTrain(
              
//               );
//             }
//           }).catchError(
//             (error) {
//               showDialog(
//                 context: context,
//                 builder: ((ctx) {
//                   return AlertDialog(
//                     title: Text(
//                       'An Alert Occured!',
//                     ),
//                     content: Text('Something Went Wrong'),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(ctx).pop();
//                         },
//                         child: Text('Okay'),
//                       ),
//                     ],
//                   );
//                 }),
//               );
//             },
//           );
//         },
//         style: ButtonStyle(
//             backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
//         child: const Text(
//           'Add Train',
//           style: TextStyle(fontSize: 24, color: Colors.black),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Image.asset(
//               'assets/images/back5.jpeg',
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16.0),
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       const Center(
//                         child: Text(
//                           textAlign: TextAlign.start,
//                           'Add Train Details Now !',
//                           style: TextStyle(
//                             fontSize: 30,
//                             fontFamily: 'Alton',
//                             color: Colors.yellow,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       const Center(
//                         child: Text(
//                           ' Fill Out The Form !',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontSize: 24,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
                     
//                       _iconButton(context),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
