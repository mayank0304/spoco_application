import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:spoco_app/screens/profile_page.dart';


/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.


class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;

  List widgets = [
    const Text("Home Page"),
    const Text("Sports"),
    const ProfilePage()
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
      appBar: AppBar(
        title: const Text("Home",
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        actions: [
              IconButton(
                  onPressed: signout, icon: const Icon(Icons.logout_rounded),
                  ),
            ]
      ),
      body: Center(
        child: widgets[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const  [
        BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.blue,), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.sports_football, color: Colors.blue,), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.blue,), label: "Home")
      ],
      currentIndex: selectedIndex,
      onTap: onItemTaped,
      ),
    );
  }
}