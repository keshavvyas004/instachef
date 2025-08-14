import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instachef/screens/home_screen.dart';
import 'package:instachef/screens/search_screen.dart';
import 'package:instachef/screens/post_screen.dart';
import 'package:instachef/screens/profile_screen.dart';

// Main entry point of the application.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      routes: {
        'home': (context) => const MainNavigationScreen(),
        // Add other routes as needed
      },
      title: 'InstaChef',
      theme: ThemeData(canvasColor: const Color(0xFF2196F3)),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // The rich HomeScreen widget from 'home_screen.dart' will be used here.
    HomeScreen(),
    SearchScreen(),
    PostScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isHomeScreen = _selectedIndex == 0;

    return Scaffold(
      appBar: isHomeScreen
          ? AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(255, 7, 223, 0),
        title: Text(
          'InstaChef',
          style: GoogleFonts.cookie(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            fontSize: 40,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  color: Colors.white,
                  onPressed: () {
                    debugPrint('Request button pressed!');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.sms_outlined),
                  color: Colors.white,
                  onPressed: () {
                    debugPrint('Message button pressed');
                  },
                ),
              ],
            ),
          ),
        ],
      )
          : null,
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.blue[700],
          selectedItemColor: const Color.fromARGB(255, 7, 223, 0),
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}