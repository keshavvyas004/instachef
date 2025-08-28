import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instachef/screens/home_screen.dart';
import 'package:instachef/screens/login_screen.dart';
import 'package:instachef/screens/search_screen.dart';
import 'package:instachef/screens/post_screen.dart';
import 'package:instachef/screens/profile_screen.dart';
import 'package:instachef/screens/signup_screen_1.dart';
import 'package:instachef/screens/signup_screen_2.dart';
import 'package:instachef/screens/signup_screen_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'login',
      routes: {
        'login': (context) => const MyLogin(),
        'home': (context) => const MainNavigationScreen(),
        'register_1': (context) => const SignUp1(),
        'register_2': (context) => const SignUp2(),
        'register_3': (context) => const SignUp3(),
      },
      title: 'InstaChef',
      theme: ThemeData(canvasColor: const Color.fromRGBO(15, 29, 37, 1)),
      home: const MainNavigationScreen(),
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
    HomeScreen(),
    MySearchScreen(),
    RecipePostScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color.fromRGBO(15, 29, 37, 1),
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
      ),
      body: Center(
        child: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(15, 29, 37, 1),
          selectedItemColor: const Color.fromRGBO(247, 158, 27, 1),
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
