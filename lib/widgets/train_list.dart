import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/ticket_screen.dart';
import 'package:ticket_widget/ticket_widget.dart';
//import 'package:intl/intl.dart';
import '../data/train_dummy.dart';

class TrainList extends StatefulWidget {
  const TrainList({super.key});

  @override
  State<TrainList> createState() => _TrainListState();
}

class _TrainListState extends State<TrainList> {
  @override
  Widget build(BuildContext context) {
    final listOfTrains = Provider.of<TrainDummy>(
      context,
    ).filteredList;
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Container(
          height: 380,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 26),
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
                      width: 10,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Provider.of<TrainDummy>(context, listen: false)
                            .setTicketPrice(listOfTrains[index].ticketPrice);
                        Navigator.of(context).pushNamed(TicketScreen.routeName,
                            arguments: listOfTrains[index].id.toString());
                      },
                      child: const Text(
                        'See Details',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      itemCount: listOfTrains.length,
    );
  }
}
