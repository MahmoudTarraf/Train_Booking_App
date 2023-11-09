import 'package:flutter/material.dart';
import '../data/train_dummy.dart';
import '../screens/tabs_screen.dart';
import 'package:provider/provider.dart';

import 'package:ticket_widget/ticket_widget.dart';

class UserTicketsScreen extends StatelessWidget {
  const UserTicketsScreen({super.key});
  static const routeName = '/user_ticket_screen';

  @override
  Widget build(BuildContext context) {
    final listOfTrain = Provider.of<TrainDummy>(context).niggasTrains;
    final listOfTrains = listOfTrain.toSet().toList();
    final nameList = Provider.of<TrainDummy>(context, listen: false).nameList;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/back5.jpeg'),
              ),
            ),
          ),
          listOfTrains.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        'No Trips Yet!',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        'Start Adding!',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    IconButton(
                        iconSize: 40,
                        color: Colors.white,
                        onPressed: () => Navigator.of(context)
                            .pushNamed(TabsScreen.routeName),
                        icon: const Icon(Icons.arrow_forward_sharp))
                  ],
                )
              : ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Container(
                      height: 500,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TicketWidget(
                        color: Colors.white.withOpacity(0.7),
                        width: 350,
                        height: 500,
                        isCornerRounded: true,
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.yellow,
                                    child: Text(
                                      '#${listOfTrains[index].trainNumber}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    listOfTrains[index].trainName,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 26),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/new_train2.png',
                                  width: 100,
                                  height: 100,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Station :',
                                  style: TextStyle(fontSize: 23),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    listOfTrains[index].stationName,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 23,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'OnBoarding Time :',
                                  style: TextStyle(fontSize: 23),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    listOfTrains[index].onBoardingTime,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: const TextStyle(
                                      fontSize: 23,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Returning Time :',
                                  style: TextStyle(fontSize: 23),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    listOfTrains[index].returningTime,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: const TextStyle(
                                      fontSize: 23,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Trip Date :',
                                  style: TextStyle(fontSize: 23),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    listOfTrains[index].tripDate,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: const TextStyle(
                                      fontSize: 23,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Available Seats :',
                                  style: TextStyle(fontSize: 23),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    listOfTrains[index]
                                        .numberOfAvailablePassengers
                                        .toString(),
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: const TextStyle(
                                      fontSize: 23,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Reservation Names :',
                                  style: TextStyle(fontSize: 23),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 130, maxWidth: 300),
                              child: ListView.builder(
                                itemCount: nameList.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    nameList[index],
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: listOfTrains.length,
                )
        ],
      ),
    );
  }
}
