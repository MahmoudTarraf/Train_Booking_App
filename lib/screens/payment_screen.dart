// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../data/auth.dart';
import '../data/train_dummy.dart';
import '../models/train.dart';
import '../screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/full_name.dart';
import '../user_authentication/gender.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const routeName = '/payment_screen';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _balance = 0;
  int _ticketPrice = 2000;
  bool isFirst = false;
  List<String> nameList = [];
  @override
  void didChangeDependencies() async {
    if (!isFirst) {
      _balance = Provider.of<Auth>(context, listen: false).userBalance;

      _ticketPrice =
          Provider.of<TrainDummy>(context, listen: false).finalticketPrice;
      isFirst = true;
    }
    isFirst = true;
    super.didChangeDependencies();
  }

  void setFullName(listOfNames) {
    nameList.addAll(listOfNames);
  }

  void setGender(String gender) {}

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget getTextFields(int number) {
    return Column(
      children: List.generate(number, (index) {
        return Column(
          children: [
            FullName(dullNameHandler: setFullName),
            const SizedBox(
              height: 20,
            ),
            Gender(genderHandler: setGender),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.amber,
              thickness: 2,
            )
          ],
        );
      }),
    );
  }

  int _selectedNumber = 1;
  Future<void> bookTrip({
    required List<String> nameLists,
    required String tripId,
    required int seats,
    required String trainName,
    required trainNumber,
    required Train thisTrain,
  }) async {
    final tripPrice =
        Provider.of<TrainDummy>(context, listen: false).finalticketPrice;
    Provider.of<TrainDummy>(context, listen: false).setNameList(nameLists);
    if (thisTrain.numberOfAvailablePassengers >= seats) {
      final nameList = nameLists.toSet().toList();
      final userData =
          await Provider.of<Auth>(context, listen: false).getUserData();
      final userId = userData['User Id'] as String;
      final tripUrl =
          'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/trips/$tripId.json';
      final usersUrl =
          'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/trips/$tripId/users/$userId.json';

      final balance = userData['Balance'] as int;
      try {
        if (balance >= tripPrice) {
          final response = await http.get(Uri.parse(tripUrl));

          if (response.statusCode == 200) {
            final data = json.decode(response.body);

            if (data != null) {
              final currentSeats = data['seats'] as int;
              final updatedSeats = currentSeats + seats;
              final updatedData = {...data, 'seats': updatedSeats};
              await http.put(Uri.parse(tripUrl),
                  body: json.encode(updatedData));
              await Provider.of<Auth>(context, listen: false).updateUserBalance(
                seats,
                balance,
                tripPrice,
              );
            } else {
              final data = {
                'id': tripId,
                'seats': seats,
                'train number': trainNumber,
                'trian name': trainName
              };
              await http.put(Uri.parse(tripUrl), body: json.encode(data));
              await Provider.of<Auth>(context, listen: false)
                  .updateUserBalance(seats, balance, tripPrice);
            }
            // Add the user ID and name to the list of users for the trip
            final userResponse = await http.get(Uri.parse(usersUrl));

            final usersData = json.decode(userResponse.body);
            if (usersData != null) {
              try {
                final updatedUsersData = [...usersData, ...nameList];
                await http.put(Uri.parse(usersUrl),
                    body: json.encode(updatedUsersData));
              } catch (e) {
                rethrow;
              }
            } else {
              final newUsersData = [...nameList];
              await http.put(Uri.parse(usersUrl),
                  body: json.encode(newUsersData));

              await http.put(Uri.parse(usersUrl),
                  body: json.encode(newUsersData));
            }
          } else if (response.statusCode == 404) {
            // Trip doesn't exist, create a new one
            final data = {
              'id': tripId,
              'seats': seats,
              'train number': trainNumber,
              'trian name': trainName
            };
            await http.put(Uri.parse(tripUrl), body: json.encode(data));
            await Provider.of<Auth>(context, listen: false)
                .updateUserBalance(seats, balance, tripPrice);
            // Add the user ID and name to the list of users for the trip
            final newUsersData = [nameList];
            await http.put(Uri.parse(usersUrl),
                body: json.encode(newUsersData));
          } else {
            throw Exception(
                'Failed to store trip details: ${response.statusCode}');
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Registration Made Successfully Nigga',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.teal,
                ),
              ),
              duration: Duration(seconds: 3),
            ),
          );
          Provider.of<TrainDummy>(context, listen: false)
              .storeAndGetTrains(thisTrain);

          // Provider.of<TrainDummy>(context).getNameList(nameList);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Not Enough Money Nigga',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                ),
              ),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }
      } catch (message) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'An Error Occured!',
              style: TextStyle(fontSize: 23),
            ),
            content: Text(
              message.toString(),
              style: const TextStyle(fontSize: 23),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text(
                  'Okay',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        );
        return;
      }
      await Provider.of<TrainDummy>(context, listen: false).updateTrainSeats(
        trainNumber: trainNumber,
        trainId: thisTrain.id,
        seats: seats,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Not Enough Seats Nigga',
            style: TextStyle(
              fontSize: 22,
              color: Colors.red,
            ),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final thisTrain = ModalRoute.of(context)!.settings.arguments as Train;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/images/back6.jpeg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Fill The Payment Form',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'How Many Seats?',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          DropdownButton<int>(
                            underline: Container(),
                            borderRadius: BorderRadius.circular(15),
                            style: const TextStyle(
                                color: Colors.red, fontSize: 20),
                            value: _selectedNumber,
                            items: [1, 2, 3, 4, 5, 6]
                                .map((number) => DropdownMenuItem<int>(
                                      value: number,
                                      child: Text(number.toString()),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedNumber = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      getTextFields(_selectedNumber),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.grey.shade700,
                            child: Column(
                              children: [
                                const Text(
                                  'Note:',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 26,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Price For Ticket:      $_ticketPrice SP',
                                  style: const TextStyle(
                                      color: Colors.amber, fontSize: 24),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Your Balance:     $_balance',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  _formKey.currentState!.save();
                                  await bookTrip(
                                    thisTrain: thisTrain,
                                    nameLists: nameList,
                                    seats: _selectedNumber,
                                    trainName: thisTrain.trainName,
                                    trainNumber: thisTrain.trainNumber,
                                    tripId: thisTrain.id,
                                  );
                                  Navigator.of(context).pushReplacementNamed(
                                      TabsScreen.routeName);
                                },
                                child: const Text(
                                  'Book Now!',
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  _formKey.currentState!.save();
                                  await bookTrip(
                                    thisTrain: thisTrain,
                                    nameLists: nameList,
                                    seats: _selectedNumber,
                                    trainName: thisTrain.trainName,
                                    trainNumber: thisTrain.trainNumber,
                                    tripId: thisTrain.id,
                                  );

                                  Navigator.of(context).pushReplacementNamed(
                                      TabsScreen.routeName);
                                },
                                icon:
                                    const Icon(Icons.airplane_ticket_outlined),
                                color: Colors.amber,
                                iconSize: 30,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
