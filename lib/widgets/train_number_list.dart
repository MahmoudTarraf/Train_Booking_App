import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../screens/update_train_screen.dart';

import '../models/train.dart';

class TrainNumberList extends StatelessWidget {
  const TrainNumberList({required this.thisTrain, super.key});
  final Train thisTrain;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: TicketWidget(
        color: Colors.white.withOpacity(0.7),
        width: 400,
        height: 380,
        isCornerRounded: true,
        margin: const EdgeInsets.all(5),
        child: SingleChildScrollView(
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
                      backgroundColor: Colors.purple,
                      child: Text(
                        '#${thisTrain.trainNumber}',
                        style: const TextStyle(
                          color: Colors.white,
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
                      thisTrain.trainName,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: const TextStyle(color: Colors.black, fontSize: 26),
                    ),
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
                      thisTrain.stationName,
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
                      thisTrain.onBoardingTime,
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
                      thisTrain.returningTime,
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
                      thisTrain.numberOfAvailablePassengers.toString(),
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
                    'Destination From :',
                    style: TextStyle(fontSize: 23),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      thisTrain.destinationFrom.toString(),
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
                    'Destination  To :',
                    style: TextStyle(fontSize: 23),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      thisTrain.destinationTo.toString(),
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
                    'Statios Stops :',
                    style: TextStyle(fontSize: 23),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      thisTrain.listOfStops.toString(),
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          UpdateTrainScreen.routeName,
                          arguments: thisTrain);
                    },
                    child: const Text(
                      'Update This Train!',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
