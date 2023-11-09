import 'package:flutter/material.dart';
import '../data/train_dummy.dart';
import 'package:provider/provider.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../models/train.dart';

class DeleteTrain extends StatelessWidget {
  const DeleteTrain({required this.thisTrain, super.key});
  final Train thisTrain;
  Future<void> deleteTrain(BuildContext context, int trainNumber) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deleting"),
          content: const Text("Are you sure you want to delete this train?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        // User confirmed the edit, do something here
        Provider.of<TrainDummy>(context, listen: false)
            .deleteTrain(trainNumber);
      }
    }).catchError((error) {
      showDialog(
          context: context,
          builder: ((ctx) {
            return AlertDialog(
              title: const Text(
                'An Alert Occured!',
              ),
              content: const Text('Something Went Wrong'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Okay'),
                ),
              ],
            );
          }));
    });
  }

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
                    onPressed: () =>
                        deleteTrain(context, thisTrain.trainNumber),
                    child: const Text(
                      'Delete This Train!',
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
