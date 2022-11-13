import 'package:flutter/material.dart';
import 'calendar.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(SchoolManagement());
}

class SchoolManagement extends StatefulWidget {
  static const String id = 'schoolManagement';
  @override
  _SchoolManagementState createState() => _SchoolManagementState();
}

class _SchoolManagementState extends State<SchoolManagement> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  int _selectedItemIndex = 0;
  final List pages = [
    HomePage(),
    null,
    null,
    CalendarPage(),
    null,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Color(0xFFF0F0F0),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
          currentIndex: _selectedItemIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              _selectedItemIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.home),
              tooltip: "Return Home",
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.insert_chart),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.done),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.calendar_today),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.chat_bubble),
            ),
          ],
        ),
        body: pages[_selectedItemIndex]);
  }
}
