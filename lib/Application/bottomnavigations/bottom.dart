import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/Application/bottomnavigations/help/Help.dart';
import 'package:login/Application/bottomnavigations/history/History.dart';
import 'package:login/Application/bottomnavigations/home/home.dart';
import 'package:login/Application/bottomnavigations/my%20account/myaccnt.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;
  List<Widget> _pages = [Home(), History(), Help(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        currentIndex: _currentIndex, // Current selected index
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_center_outlined),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showUnselectedLabels: true,
      ),
      body: _pages[_currentIndex],
    );
  }
}
