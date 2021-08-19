import 'package:edify/screens/addpost.dart';
import 'package:edify/screens/home.dart';
import 'package:edify/screens/loginPage.dart';
import 'package:edify/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Edify ',
        debugShowCheckedModeBanner: false,
        // home: MyHomePage(title: 'A clutter free social media'),
        home: currentUser != null ? MyHomePage(title: 'Edify') : LoginScreen(),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _tabs = [
    HomeScreen(),
    AddPost(),
    ProfilePage(),
    // see the HomeTab class below
    // see the SettingsTab class below
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.lightBlueAccent,

        height: 45,
        // (MediaQuery.of(context).size.height ) / 100 * 40,

        onTap: onTabTapped, // new
        index: _currentIndex, //
        items: [
          Icon(
            Icons.home,
            color: Colors.lightBlueAccent,
          ),
          Icon(
            Icons.add_circle_rounded,
            color: Colors.lightBlueAccent,
          ),
          Icon(
            Icons.person,
            color: Colors.lightBlueAccent,
          ),
        ],
      ),
      body: _tabs[_currentIndex],
    );
  }
}
