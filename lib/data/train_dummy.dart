import 'package:flutter/widgets.dart';

import '../models/train.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class TrainDummy with ChangeNotifier {
  List<Train> trainList = [
    Train(
        tripDate: '',
        ticketPrice: 0,
        listOfStops: 'null',
        id: 'noSuchElement',
        trainNumber: -1,
        trainName: 'train to busan',
        onBoardingTime: 'Sun_20_May',
        returningTime: '4:20',
        numberOfAvailablePassengers: 1000,
        stationName: 'null',
        destinationFrom: 'null',
        destinationTo: 'null'),
  ];
  String trainId = '';
  List<Train> filteredList = [];
  //List<int> ticketPrice = [];
  int finalticketPrice = 0;
  List<String> emailList = [];
  List<Train> niggasTrains = [];
  List<String> nameList = [];
  List<Train> trainList2 = [];
  List<Train> trainList3 = [];
  List<Train> get listOfTrains {
    return trainList;
  }

  static String selectedFrom = '';
  static String selectedTo = '';
  void refreshData(String from, String to) {
    selectedFrom = from;
    selectedTo = to;
  }

  Train findByTrainNumber(int number) {
    late Train result;
    for (Train t in trainList2) {
      if (t.trainNumber == number) {
        result = t;
        return result;
      }
    }
    return Train(
      tripDate: '',
      ticketPrice: 0,
      listOfStops: '',
      destinationFrom: '',
      destinationTo: '',
      id: '',
      trainName: '',
      trainNumber: -1,
      numberOfAvailablePassengers: -1,
      onBoardingTime: '',
      returningTime: '',
      stationName: '',
    );
  }

  void storeAndGetTrains(Train train) {
    niggasTrains.add(train);
    notifyListeners();
  }

  Future<void> addTrain({
    required String trainName,
    required int trainNumber,
    required String onBoardingTime,
    required String returningTime,
    required int numberOfAvailablePassengers,
    required String stationName,
    required String destinationFrom,
    required String destinationTo,
    required String listOfStops,
    required int ticketPrice,
    required String tripDate,
  }) async {
    const url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/trains.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'Train Name': trainName,
          'Train Number': trainNumber,
          'OnBoarding Time': onBoardingTime,
          'Returning Time': returningTime,
          'Number Of Available Seats': numberOfAvailablePassengers,
          'Station Name': stationName,
          'Destination From': destinationFrom,
          'Destination To': destinationTo,
          'List Of Stops': listOfStops,
          'Ticket Price': ticketPrice,
          'Trip Date': tripDate,
        }),
      );

      final newTrain = Train(
        tripDate: tripDate,
        ticketPrice: ticketPrice,
        id: json.decode(response.body)['name'],
        trainName: trainName,
        trainNumber: trainNumber,
        numberOfAvailablePassengers: numberOfAvailablePassengers,
        onBoardingTime: onBoardingTime,
        returningTime: returningTime,
        stationName: stationName,
        destinationFrom: destinationFrom,
        destinationTo: destinationTo,
        listOfStops: listOfStops,
      );
      trainList.add(newTrain);
      // catchError((error) {
      //   throw error;
      // });
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void setNameList(finalNameList) {
    nameList = finalNameList;
    notifyListeners();
  }

  Train findById(String id) {
    return trainList.firstWhere((train) => train.id == id);
  }

  Future<void> getTrainsData(String from, String to) async {
    const url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/trains.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final selectedData =
            json.decode(response.body) as Map<String, dynamic>?;
        if (selectedData != null) {
          final List<Train> fetchedData = [];
          selectedData.forEach((prodId, prodData) {
            if (prodData != null && prodData is Map<String, dynamic>) {
              fetchedData.add(
                Train(
                  tripDate: prodData['Trip Date'] ?? '',
                  ticketPrice: prodData['Ticket Price'] ?? 0,
                  id: prodId,
                  trainName: prodData['Train Name'] ?? '',
                  trainNumber: prodData['Train Number'] ?? '',
                  numberOfAvailablePassengers:
                      prodData['Number Of Available Seats'] ?? 0,
                  onBoardingTime: prodData['OnBoarding Time'] ?? '',
                  returningTime: prodData['Returning Time'] ?? '',
                  stationName: prodData['Station Name'] ?? '',
                  destinationFrom: prodData['Destination From'] ?? '',
                  destinationTo: prodData['Destination To'] ?? '',
                  listOfStops: prodData['List Of Stops'] ?? '',
                ),
              );
            }
          });
          trainList = fetchedData;
          filteredList = trainList
              .where((train) =>
                  train.destinationFrom == from && train.destinationTo == to)
              .toList();
        }
      } else if (response.statusCode == 404) {
        trainList = trainList;
        filteredList = [];
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateTrain(
      {required int trainNumber, required Train train}) async {
    //final trainIndex = trainList.indexWhere((train) => train.id == id);
    final thisTrain =
        trainList2.firstWhere((element) => element.trainNumber == trainNumber);
    final thisIndex = trainList2.indexOf(thisTrain);

    final url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/trains/${thisTrain.id}.json';
    try {
      await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'Train Name': train.trainName,
            'Train Number': train.trainNumber,
            'Number Of Available Seats': train.numberOfAvailablePassengers,
            'Returning Time': train.returningTime,
            'OnBoarding Time': train.onBoardingTime,
            'List Of Stops': train.listOfStops,
            'Destination To': train.destinationTo,
            'Destination From': train.destinationFrom,
            'Station Name': train.stationName,
            'Ticket Price': train.ticketPrice,
            'Trip Date': train.tripDate,
          },
        ),
      );
      trainList[thisIndex] = thisTrain;
      trainList2[thisIndex] = thisTrain;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateTrainSeats(
      {required int trainNumber,
      required String trainId,
      required int seats}) async {
    //final trainIndex = trainList.indexWhere((train) => train.id == id);
    final thisTrain =
        trainList.firstWhere((element) => element.trainNumber == trainNumber);
    final thisIndex = trainList.indexOf(thisTrain);

    final url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/trains/${thisTrain.id}.json';
    try {
      await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'Number Of Available Seats':
                thisTrain.numberOfAvailablePassengers - seats,
          },
        ),
      );
      trainList[thisIndex].numberOfAvailablePassengers =
          thisTrain.numberOfAvailablePassengers - seats;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getData() async {
    const url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/trains.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final selectedData =
            json.decode(response.body) as Map<String, dynamic>?;
        if (selectedData != null) {
          final List<Train> fetchedData = [];
          selectedData.forEach((prodId, prodData) {
            if (prodData != null && prodData is Map<String, dynamic>) {
              fetchedData.add(
                Train(
                  tripDate: prodData['Trip Date'] ?? '',
                  ticketPrice: prodData['Ticket Price'] ?? 0,
                  id: prodId,
                  trainName: prodData['Train Name'] ?? '',
                  trainNumber: prodData['Train Number'] ?? '',
                  numberOfAvailablePassengers:
                      prodData['Number Of Available Seats'] ?? 0,
                  onBoardingTime: prodData['OnBoarding Time'] ?? '',
                  returningTime: prodData['Returning Time'] ?? '',
                  stationName: prodData['Station Name'] ?? '',
                  destinationFrom: prodData['Destination From'] ?? '',
                  destinationTo: prodData['Destination To'] ?? '',
                  listOfStops: prodData['List Of Stops'] ?? '',
                ),
              );
            }
          });
          trainList2 = fetchedData;
        }
      } else if (response.statusCode == 404) {
        trainList = trainList;
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getDataForDelete() async {
    const url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/trains.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final selectedData =
            json.decode(response.body) as Map<String, dynamic>?;
        if (selectedData != null) {
          final List<Train> fetchedData = [];
          selectedData.forEach((prodId, prodData) {
            if (prodData != null && prodData is Map<String, dynamic>) {
              fetchedData.add(
                Train(
                  tripDate: prodData['Trip Date'] ?? '',
                  ticketPrice: prodData['Ticket Price'] ?? 0,
                  id: prodId,
                  trainName: prodData['Train Name'] ?? '',
                  trainNumber: prodData['Train Number'] ?? '',
                  numberOfAvailablePassengers:
                      prodData['Number Of Available Seats'] ?? 0,
                  onBoardingTime: prodData['OnBoarding Time'] ?? '',
                  returningTime: prodData['Returning Time'] ?? '',
                  stationName: prodData['Station Name'] ?? '',
                  destinationFrom: prodData['Destination From'] ?? '',
                  destinationTo: prodData['Destination To'] ?? '',
                  listOfStops: prodData['List Of Stops'] ?? '',
                ),
              );
            }
          });
          trainList3 = fetchedData;
        }
      } else if (response.statusCode == 404) {
        trainList = trainList;
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteTrain(int trainNumber) async {
    Train? thisTrain =
        trainList3.firstWhere((element) => element.trainNumber == trainNumber);
    final thisIndex = trainList3.indexOf(thisTrain);
    trainList.removeAt(thisIndex);
    notifyListeners();
    final url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/trains/${thisTrain.id}.json';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      trainList.insert(thisIndex, thisTrain);
      notifyListeners();
      throw HttpException('Could Not Delete Train.');
    }
    thisTrain = null;
  }

  Future<void> updateTrainTicketPrice(
      {required int trainNumber,
      required String trainId,
      required int ticketPrice}) async {
    //final trainIndex = trainList.indexWhere((train) => train.id == id);
    // final thisTrain =
    //     trainList.firstWhere((element) => element.trainNumber == trainNumber);
    // final thisIndex = trainList.indexOf(thisTrain);

    final url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/trains/$trainId.json';
    try {
      await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'Ticket Price': ticketPrice,
          },
        ),
      );
      // trainList[thisIndex].ticketPrice = thisTrain.ticketPrice;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getUsersData() async {
    const url =
        'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/users.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final selectedData =
            json.decode(response.body) as Map<String, dynamic>?;
        if (selectedData != null) {
          final List<String> fetchedData = [];
          selectedData.forEach((prodId, prodData) {
            if (prodData != null && prodData is Map<String, dynamic>) {
              fetchedData.add(
                prodData['Email'] ?? 0,
              );
            }
          });
          emailList = fetchedData;
        }
      } else if (response.statusCode == 404) {
        emailList = emailList;
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  // Future<void> getTripPrice(String trainId) async {
  //   print(trainId);
  //   final url =
  //       'https://mahmoudproject-2ded7-default-rtdb.firebaseio.com/trains/$trainId.json';
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       final selectedData =
  //           json.decode(response.body) as Map<String, dynamic>?;
  //       if (selectedData != null) {
  //         final List<int> fetchedData = [];
  //         selectedData.forEach((prodId, prodData) {
  //           print(prodData);
  //           if (prodData != null && prodData is Map<String, dynamic>) {
  //             fetchedData.add(
  //               prodData['Ticket Price'] ?? 2000,
  //             );
  //           }
  //         });
  //         ticketPrice = fetchedData;
  //         print(ticketPrice);
  //       }
  //     } else if (response.statusCode == 404) {
  //       ticketPrice = ticketPrice;
  //     }
  //     notifyListeners();
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  void setTrainId(String id) {
    trainId = id;
    notifyListeners();
  }

  void setTicketPrice(int x) {
    finalticketPrice = x;
    notifyListeners();
  }
}
