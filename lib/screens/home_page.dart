import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/screens/list_my_turfs.dart';
import 'package:spoco_app/screens/list_turfs.dart';
import 'package:spoco_app/screens/profile_page.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List widgets = [
    const ListTurfs(),
    const ListMyTurfs(),
    const ProfilePage(),
  ];

  onItemTaped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: widgets[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor:const  Color(0xFF1A3636),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        // elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                // color: Colors.blue,
              ),
              label: "Home",
              ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.grass,
                // color: Colors.blue,
              ),
              label: "My Turfs"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                // color: Colors.blue,
              ),
              label: "Profile"),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTaped,
      ),
    );
  }
}
