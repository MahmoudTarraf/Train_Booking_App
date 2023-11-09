// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../screens/payment_screen.dart';
import '../screens/train_details.dart';
import 'package:provider/provider.dart';
import '../widgets/settings.dart';
import '/data/train_dummy.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../widgets/the_final_map.dart';

class TicketScreen extends StatelessWidget {
  void getWeather(String location, BuildContext ctx) async {
    const apiKey = '62e39a36979f05b956a892bb3f4e6767';
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Weather data retrieved successfully
      final data = jsonDecode(response.body);
      final weather = data['weather'][0]['description'];
      final temperature = data['main']['temp'];
      // Display weather data in a dialog box
      showDialog(
        context: ctx,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey.shade500,
          title: Text(
            'Current Weather for $location',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weather: $weather',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Temperature: ${temperature.toString()}°C',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Feels Like: ${data['main']['feels_like'].toString()}°C',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Humidity: ${data['main']['humidity'].toString()}%',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Wind Speed: ${data['wind']['speed'].toString()} km/h',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Error retrieving weather data
      showDialog(
        context: ctx,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to retrieve weather data.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  const TicketScreen({super.key});
  static const String routeName = 'ticket_screen';
  @override
  Widget build(BuildContext context) {
    var routeArgs = ModalRoute.of(context)!.settings.arguments != null
        ? ModalRoute.of(context)!.settings.arguments as String
        : 'noSuchElement';
    var trainId = routeArgs;
    var thisTrain = Provider.of<TrainDummy>(context).findById(trainId);

    return trainId == 'noSuchElement'
        ? Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/back6.jpeg'),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                top: 33,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Settings.routeName);
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.amber,
                    size: 50,
                  ),
                ),
              ),
              Positioned(
                right: 180,
                bottom: 200,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(TrainDetails.routeName);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.yellow,
                      size: 40,
                    )),
              ),
              const Center(
                child: Text(
                  'No Trains Were Selected,\n             Select Now !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/back6.jpeg'),
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Get Your Ticket !',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 20),
                        child: TicketWidget(
                          color: Colors.white.withOpacity(0.7),
                          width: 400,
                          height: 520,
                          isCornerRounded: true,
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                    'Trip Date :',
                                    style: TextStyle(fontSize: 23),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      thisTrain.tripDate,
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
                                      thisTrain.numberOfAvailablePassengers
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
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    'Ticket Price :',
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
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          PaymentScreen.routeName,
                                          arguments: thisTrain);
                                    },
                                    child: const Text(
                                      'Book Now!',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        Navigator.of(context).pushNamed(
                                      PaymentScreen.routeName,
                                      arguments: thisTrain,
                                    ),
                                    icon: const Icon(
                                        Icons.airplane_ticket_outlined),
                                    color: Colors.red,
                                    iconSize: 30,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () =>
                                getWeather(thisTrain.destinationTo, context),
                            child: const Text(
                              'check Weather !',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                              onPressed: () =>
                                  getWeather(thisTrain.destinationTo, context),
                              icon: const Icon(Icons.question_mark),
                              color: Colors.teal)
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pushNamed(
                                TheFinalMap.routeName,
                                arguments: thisTrain.destinationTo),
                            child: const Text(
                              'See On Google Maps !',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pushNamed(
                              TheFinalMap.routeName,
                              arguments: thisTrain.destinationTo,
                            ),
                            icon: const Icon(
                              Icons.map,
                            ),
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
