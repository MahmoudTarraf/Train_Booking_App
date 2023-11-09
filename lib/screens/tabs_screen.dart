import 'package:flutter/material.dart';
import './train_details.dart';
import './search_screen.dart';
import './ticket_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs_screen';
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _selectedScreens;
  var _selectedIndex = 0;
  //late PageController _pageController;

  // ignore: unused_element
  void _selectedWidget(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // _pageController = PageController(initialPage: _selectedIndex);

    _selectedScreens = [
      {
        'screen': const SearchScreen(),
        'title': 'SEARCH FOR TRAINS',
      },
      {
        'screen': const TrainDetails(),
        'title': 'My Ticket',
      },
      {
        'screen': const TicketScreen(),
        'title': 'See Train Details !',
      },
    ];
    // _checkEmailVerification();
    super.initState();
  }

  // Future<void> _checkEmailVerification() async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     await user.reload();
  //     setState(() {
  //       _isEmailVerified = user.emailVerified;
  //     });
  //   }
  // }
  /*@override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }*/

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
      /*_pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );*/
    });
  }

  @override
  Widget build(BuildContext context) {
    /*if (!_isEmailVerified) {
      // return  Scaffold(
      //   body: Center(
      //     child: Text(
      //       'Please verify your email address to access this screen.',
      //       style: TextStyle(fontSize: 22, color: Colors.red),
      //     ),
      //   ),
      // );
      Navigator.of(context).pushReplacementNamed(LogIn.routeName);
    }*/
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: _selectedScreens[_selectedIndex]['screen'] as Widget,
        // PageView(
        // controller: _pageController,
        /*onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },*/
        //children: [
        /*..._selectedScreens.map(
              (tab) {
                return _selectedScreens[_selectedIndex]['screen'] as Widget;
              },
            ).toList(),*/
        // ],

        bottomNavigationBar: BottomNavigationBar(
          iconSize: 25,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.yellow,
          // onTap: _selectedWidget,
          // currentIndex: _selectedIndex,
          currentIndex: _selectedIndex,
          onTap: _onBottomNavTapped,
          selectedFontSize: 17,
          backgroundColor: Colors.black,
          unselectedFontSize: 15,
          selectedIconTheme: const IconThemeData(
            color: Colors.yellow,
          ),
          //type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
              // backgroundColor: Colors.pink,
              label: 'Search',
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              //backgroundColor: Colors.pink,
              label: 'Train Details',
              icon: Icon(
                Icons.train,
              ),
            ),
            BottomNavigationBarItem(
              //backgroundColor: Colors.pink,
              label: 'Ticket Details',
              icon: Icon(
                Icons.airplane_ticket,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
