import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/settings.dart';
import '../widgets/train_list.dart';
import '../data/train_dummy.dart';

class TrainDetails extends StatefulWidget {
  const TrainDetails({super.key});
  static const routeName = '/train_screen';

  @override
  State<TrainDetails> createState() => _TrainDetailsState();
}

class _TrainDetailsState extends State<TrainDetails> {
  var selectedFrom = TrainDummy.selectedFrom;
  var selectedTo = TrainDummy.selectedTo;
  Future<void> getData() async {
    await Provider.of<TrainDummy>(context, listen: false)
        .getTrainsData(selectedFrom, selectedTo)
        .then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/train_details.jpg'),
              ),
            ),
          ),
          Positioned(
            right: 30,
            top: 50,
            child: Container(
              alignment: Alignment.center,
              width: 300,
              color: Colors.white.withOpacity(0.5),
              child: const Text(
                'Available Trains !',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
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
                color: Colors.black,
                size: 50,
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: SizedBox(
              height: 700,
              width: 400,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 500, maxWidth: 411),
                  child: RefreshIndicator(
                      onRefresh: getData, child: const TrainList()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
