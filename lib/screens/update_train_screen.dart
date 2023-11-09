// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thefinaltest/train_adding/date_picker_new.dart';
import 'package:thefinaltest/widgets/ticket_price.dart';
import '../models/train.dart';
import '../train_adding/number_of_available_passengers.dart';
import '../train_adding/onboarding_time.dart';
import '../train_adding/returning_time.dart';
import '../train_adding/station_name.dart';
import '../train_adding/train_name.dart';
import '../train_adding/train_number.dart';
import '../train_adding/destination_from.dart';
import '../train_adding/destination_to.dart';
import '../train_adding/list_of_stops.dart';
import '../data/train_dummy.dart';

class UpdateTrainScreen extends StatelessWidget {
  UpdateTrainScreen({super.key});
  static const routeName = '/update_screen.dart';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _passengersNumber = 0;
  int _trainNumber = 0;
  String _onBoardingTime = '';
  String _returningTime = '';
  String _stationName = '';
  String _trainName = '';
  String _destinatioFrom = '';
  String _destinatioTo = '';
  String _listOfStops = '';
  int ticketPrice = 0;
  String tripDate = '';
  void setTicketPrice(int price) {
    ticketPrice = price;
  }

  void setTripDate(String date) {
    tripDate = date;
  }

  void setNumberOfAvailablePassengers(int number) {
    _passengersNumber = number;
  }

  void setTrainName(String name) {
    _trainName = name;
  }

  void setStationName(String name) {
    _stationName = name;
  }

  void setOnBoardingTime(String time) {
    _onBoardingTime = time;
  }

  void setReturningTime(String time) {
    _returningTime = time;
  }

  void setTrainNumber(int number) {
    _trainNumber = number;
  }

  void setDestinationFrom(String from) {
    _destinatioFrom = from;
  }

  void setDestinationTo(String to) {
    _destinatioTo = to;
  }

  void setTrainStops(String stops) {
    _listOfStops = stops;
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
              'assets/images/back5.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child: Text(
                          textAlign: TextAlign.start,
                          'Update Train Schedule !',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Alton',
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          ' Fill Out The Form !',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TrainName(trainHandler: setTrainName),
                      const SizedBox(
                        height: 20,
                      ),
                      TrainNumber(trainHandler: setTrainNumber),
                      const SizedBox(
                        height: 20,
                      ),
                      TicketPrice(trainHandler: setTicketPrice),
                      const SizedBox(
                        height: 20,
                      ),
                      DatePickerNew(dateHandler: setTripDate),
                      const SizedBox(
                        height: 20,
                      ),
                      StationName(stationHandler: setStationName),
                      const SizedBox(
                        height: 20,
                      ),
                      NumberOfAvailablePasssengers(
                          passengersHandler: setNumberOfAvailablePassengers),
                      const SizedBox(
                        height: 20,
                      ),
                      OnBoardingTime(onBoardingTimeHandler: setOnBoardingTime),
                      const SizedBox(
                        height: 20,
                      ),
                      ReturningTime(returningTimeHandler: setReturningTime),
                      const SizedBox(
                        height: 20,
                      ),
                      DestinationFrom(searchHandler: setDestinationFrom),
                      const SizedBox(
                        height: 20,
                      ),
                      DestinationTo(
                          searchHandlerTo: setDestinationTo,
                          selectedCountry: _destinatioFrom),
                      const SizedBox(
                        height: 20,
                      ),
                      ListOfStops(listOfStops: setTrainStops),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm Updating"),
                                  content: const Text(
                                      "Are you sure you want to update this train?"),
                                  actions: [
                                    TextButton(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Update"),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                  ],
                                );
                              },
                            ).then((value) {
                              if (value == true) {
                                // User confirmed the update, do something here
                                Provider.of<TrainDummy>(context, listen: false)
                                    .updateTrain(
                                        trainNumber: thisTrain.trainNumber,
                                        train: Train(
                                          tripDate: tripDate,
                                          ticketPrice: thisTrain.ticketPrice,
                                          id: thisTrain.id,
                                          trainName: _trainName,
                                          trainNumber: _trainNumber,
                                          onBoardingTime: _onBoardingTime,
                                          returningTime: _returningTime,
                                          numberOfAvailablePassengers:
                                              _passengersNumber,
                                          stationName: _stationName,
                                          destinationFrom: _destinatioFrom,
                                          destinationTo: _destinatioTo,
                                          listOfStops: _listOfStops,
                                        ));
                              }
                            }).catchError(
                              (error) {
                                showDialog(
                                  context: context,
                                  builder: ((ctx) {
                                    return AlertDialog(
                                      title: const Text(
                                        'An Alert Occured!',
                                      ),
                                      content:
                                          const Text('Something Went Wrong'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: const Text('Okay'),
                                        ),
                                      ],
                                    );
                                  }),
                                );
                              },
                            );
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.yellow)),
                          child: const Text(
                            'Update Train',
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
