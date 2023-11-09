import 'package:flutter/material.dart';
import '../models/train.dart';
import 'package:provider/provider.dart';
import '../data/train_dummy.dart';
import '../widgets/delete_train.dart';

// ignore: must_be_immutable
class DeleteTrainScreen extends StatefulWidget {
  static const routeName = '/delete_screen.dart';

  //final Function trainHandler;
  const DeleteTrainScreen({
    super.key,
  });

  @override
  State<DeleteTrainScreen> createState() => _DeleteTrainScreenState();
}

class _DeleteTrainScreenState extends State<DeleteTrainScreen> {
  int _trainNumber = 0;
  Train thisTrain = Train(
      tripDate: '',
      listOfStops: '',
      destinationFrom: '',
      destinationTo: '',
      id: '',
      trainName: '',
      trainNumber: 0,
      ticketPrice: 0,
      numberOfAvailablePassengers: 0,
      onBoardingTime: '',
      returningTime: '',
      stationName: '');
  bool thereIsATrain = false;

  Future<void> findATrain(int number) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    await Provider.of<TrainDummy>(context, listen: false).getData().then((_) {
      thisTrain = Provider.of<TrainDummy>(context, listen: false)
          .findByTrainNumber(_trainNumber);
      if (thisTrain.trainNumber == -1) {
        setState(() {
          thereIsATrain = false;
        });
      } else if (thisTrain.trainNumber >= 0) {
        setState(() {
          thereIsATrain = true;
        });
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _enterTrainNumber(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Train number must\'nt be empty!';
          }
          return null;
        },
        onSaved: (value) {
          String temp = value as String;
          _trainNumber = int.parse(temp);

          // trainHandler(temp);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.numbers),
          hintText: 'Train Number',
          hintStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Delete By Train Number:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: _enterTrainNumber(context),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                          onPressed: () {
                            findATrain(_trainNumber);
                          },
                          child: const Text(
                            'Search',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      thereIsATrain
                          ? SizedBox(
                              height: 450,
                              width: 600,
                              child: DeleteTrain(
                                thisTrain: thisTrain,
                              ),
                            )
                          : const Column(children: [
                              SizedBox(
                                height: 140,
                              ),
                              Center(
                                child: Text(
                                  'No Trains Were Found! \nSearch For One Now!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ]),
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
