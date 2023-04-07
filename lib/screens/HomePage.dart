import 'package:flutter/material.dart';

import 'cso_laws.dart';
import 'homepage.dart';
import 'privacy_policy.dart';
import 'user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final tabs = [
    HomeScreen(),
    UserProfile(),
    PrivacyPolicy(),
    CsoLaws(),
  ];
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "HomePage",
      child: Scaffold(
        body: tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.black,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.privacy_tip), label: 'Privacy Policy'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.description_outlined), label: 'CSO Laws'),
            ]),
      ),
    );
  }
}
