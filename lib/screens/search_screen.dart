import 'package:flutter/material.dart';
import '../widgets/settings.dart';
import 'package:provider/provider.dart';
import '/screens/train_details.dart';
import '../widgets/custom_search_bar1.dart';
import '../widgets/custom_search_bar2.dart';
import '../data/train_dummy.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const routeName = '/search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var selectedFrom = '';
  var selectedTo = '';
  var _isLoading = false;

  Future<void> fetchData() async {
    Provider.of<TrainDummy>(context, listen: false)
        .refreshData(selectedFrom, selectedTo);
    setState(() {
      _isLoading = true;
    });
    await Provider.of<TrainDummy>(context, listen: false)
        .getTrainsData(selectedFrom, selectedTo)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Search Has Been Made!"),
                  actions: [
                    TextButton(
                      child: const Text("Okay"),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        Navigator.of(context).pushNamed(TrainDetails.routeName);
                      },
                    ),
                  ],
                );
              })
          .then((value) =>
              Navigator.of(context).pushNamed(TrainDetails.routeName));
    });
  }

  void searchHandlerFrom(String selectedCountry) {
    setState(() {
      selectedFrom = selectedCountry;
    });
  }

  void searchHandlerTo(String selectedCountry) {
    setState(() {
      selectedTo = selectedCountry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/search_screen.jpeg'),
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
            left: 80,
            top: 45,
            child: Container(
              width: 400,
              color: Colors.white.withOpacity(0.3),
              child: const Text(
                'Live Times & Tickets',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            right: 40,
            top: 300,
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                'Select Your Trip !',
                style: TextStyle(
                  fontSize: 27,
                  fontStyle: FontStyle.italic,
                  color: Colors.yellow,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 110,
            bottom: 305,
            child: Text(
              'From : ',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 24,
              ),
            ),
          ),
          Positioned(
            right: 120,
            bottom: 150,
            child: Container(
              height: 50,
              width: 150,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        color: Colors.red,
                      ),
                    )
                  : TextButton(
                      onPressed: fetchData,
                      child: const Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
          ),
          _isLoading
              ? Container()
              : Positioned(
                  right: 100,
                  bottom: 153,
                  child: IconButton(
                    onPressed: fetchData,
                    icon: const Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ),
          const Positioned(
            left: 120,
            bottom: 250,
            child: Text(
              'To : ',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 24,
              ),
            ),
          ),
          Positioned(
            right: 50,
            bottom: 300,
            child: CustomSearchBar1(searchHandler: searchHandlerFrom),
          ),
          Positioned(
            right: 50,
            bottom: 245,
            child: CustomSearchBar2(
                searchHandlerTo: searchHandlerTo,
                selectedCountry: selectedFrom),
          ),
        ],
      ),
    );
  }
}
