import 'package:advolocate_app/Model/AdvocatesData.dart';
import 'package:advolocate_app/screens/AdvocateProfile.dart';
import 'package:advolocate_app/screens/cso_laws.dart';
import 'package:advolocate_app/screens/privacy_policy.dart';
import 'package:advolocate_app/screens/profile.dart';
import 'package:flutter/material.dart';

class AdvocateHomePage extends StatefulWidget {
  const AdvocateHomePage({
    super.key,
  });

  @override
  State<AdvocateHomePage> createState() => _AdvocateHomePageState();
}

class _AdvocateHomePageState extends State<AdvocateHomePage> {
  int _selectedIndex = 0;
  final tabs = [
    AdvocateProfile(),
    PrivacyPolicy(),
    CsoLaws(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.privacy_tip), label: 'Privacy Policy'),
            BottomNavigationBarItem(
                icon: Icon(Icons.description_outlined), label: 'CSO Laws'),
          ]),
    );
  }
}
