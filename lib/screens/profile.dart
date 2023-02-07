import 'dart:convert';

import 'package:advolocate_app/Model/profile_data_model.dart';
import 'package:advolocate_app/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Model/adovacate_data_model.dart';
import '../util/widgets.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final firestore = FirebaseFirestore.instance
      .collection('List of registered username')
      .snapshots();

  //bottom bar controller
  late int _selectedIndex = 1;

  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return SafeArea(
      child: loading == false
          ? WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {},
                  child: Center(
                    child: Icon(Icons.edit),
                  ),
                ),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  iconTheme: const IconThemeData(color: Colors.black),
                  centerTitle: true,
                  title: const Text(
                    'Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 0,
                ),
                body: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    child: Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Positioned(
                      top: height * 0.10,
                      bottom: height * 0.001,
                      child: Container(
                        height: height,
                        width: width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0),
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.1),

                          ///Lawyer name and address

                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      child: Text(
                                    '',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      child: const Text(
                                    'Advocate High court',
                                    style: TextStyle(fontSize: 18),
                                  )),
                                ],
                              ),

                              ///general info
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.01, right: width * 0.6),
                                child: Container(
                                    child: const Text(
                                  'General info',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              RowInfo(width, height, Icons.location_on,
                                  'Location', '[Lawyer address]', context),
                              RowInfo(width, height, Icons.balance, 'Lawsuits',
                                  '[No of clients]', context),
                              RowInfo(width, height, Icons.file_open_rounded,
                                  'File Achievement', '90%', context),
                              RowInfo(width, height, Icons.warehouse_rounded,
                                  'Experience', '10+ years', context),
                              // contact me
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.01, right: width * 0.6),
                                child: Container(
                                    child: const Text(
                                  'Contact me',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),

                              RowInfo(width, height, Icons.phone,
                                  'Phone Number', '0333-*******', context),
                              RowInfo(width, height, Icons.mail, 'Mail',
                                  'name@gmail.com', context),
                            ],
                          ),
                        ),

                        ///Lawyer name and address
                      )),
                  Positioned(
                      top: height * 0.01,
                      // right: width*0.35,
                      child: const CircleAvatar(
                        backgroundColor: Color(0xffFCD917),
                        radius: 60,
                        child: CircleAvatar(radius: 55),
                      ))
                ]),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
