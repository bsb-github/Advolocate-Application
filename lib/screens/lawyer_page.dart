import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class LawyerPage extends StatefulWidget {
  final String name;
  final String email;
  final String information;
  final String address;
  final String probono;
  const LawyerPage({
    Key? key,
    required this.name,
    required this.email,
    required this.information,
    required this.address,
    required this.probono,
  }) : super(key: key);

  @override
  State<LawyerPage> createState() => _LawyerPageState();
}

class _LawyerPageState extends State<LawyerPage> {
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, '/home');
      } else if (index == 1) {
        Navigator.pushNamed(context, '/profile');
      } else if (index == 3) {
        Navigator.pushNamed(context, '/cso_laws');
      } else if (index == 2) {
        Navigator.pushNamed(context, '/privacy_policy');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Lawyer',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Avatar and details
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.06,
                        left: width * 0.35,
                        bottom: height * 0.01,
                        right: width * 0.35),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('images/profile.png'),
                      radius: 60,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Column(
                    children: [
                      Container(
                          child: Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: height * 0.002,
                      ),
                      Container(
                          child: Text(
                        widget.email,
                        style: TextStyle(fontSize: 18),
                      )),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: height * 0.02,
            ),

            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.09, top: height * 0.03, right: width * 0.09),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Information',
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    widget.information,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Probono',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${widget.probono}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: width * 0.25,
                      ),
                      Column(
                        children: [
                          Text(
                            'Location',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.address,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyApp(),
                                ));
                          },
                          icon: Icon(
                            Icons.power_settings_new,
                            color: Colors.black,
                            size: width * 0.07,
                          )),
                      SizedBox(
                        width: width * 0.25,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: const Color(0xffFCD917)),
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xffFCD917)),
                        child: TextButton(
                          child: const Text(
                            'Contact',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: navigateBottomBar,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.privacy_tip), label: 'Privacy Policy'),
            BottomNavigationBarItem(
                icon: Icon(Icons.description_outlined), label: 'CSO Laws'),
          ]),
    ));
  }
}
