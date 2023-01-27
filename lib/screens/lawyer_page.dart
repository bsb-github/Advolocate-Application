import 'package:advolocate_app/Model/profile_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_whatsapp/open_whatsapp.dart';

import '../main.dart';

class LawyerPage extends StatefulWidget {
  final String name;
  final String email;
  final String information;
  final String address;
  final String probono;
  final String contactNumber;
  const LawyerPage({
    Key? key,
    required this.name,
    required this.email,
    required this.information,
    required this.address,
    required this.probono,
    required this.contactNumber,
  }) : super(key: key);

  @override
  State<LawyerPage> createState() => _LawyerPageState();
}

class _LawyerPageState extends State<LawyerPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
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
                      Column(
                        children: [
                          Text(
                            'Contact Number',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.contactNumber,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          FlutterOpenWhatsapp.sendSingleMessage(
                              widget.contactNumber,
                              "Hi ${widget.name} My Name is ${ProfileDataList.users[0].name} Can you help Me");
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              "Contact",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
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
    ));
  }
}
