import 'package:advolocate_app/main.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class CreateSocialUser extends StatefulWidget {
  final String email;
  final String name;
  final int type;
  final String social_id;
  const CreateSocialUser(
      {super.key,
      required this.email,
      required this.name,
      required this.social_id,
      required this.type});

  @override
  State<CreateSocialUser> createState() => _CreateSocialUserState();
}

class _CreateSocialUserState extends State<CreateSocialUser> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  // final countryController =TextEditingController();
  //  final firestore = FirebaseFirestore.instance.collection('List of registered username');
  String? stateid;
  String? statelabel;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<dynamic> state3 = [];

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
    nameController.text = widget.name;
    state3.add({'id': 'Pakistan', 'label': 'Pakistan'});
    state3.add({'id': 'Bangladesh', 'label': 'Bangladesh'});
    state3.add({'id': 'India', 'label': 'India'});
    state3.add({'id': 'Maldives', 'label': 'Maldives'});
    state3.add({'id': 'Srilanka', 'label': 'Srilanka'});
    state3.add({'id': 'Nepal', 'label': 'Nepal'});
    state3.add({'id': 'Bhutan', 'label': 'Bhutan'});
    setState(() {});
  }

  var otpGenerator = RandomStringGenerator(
    hasDigits: true,
    fixedLength: 4,
    hasAlpha: false,
    hasSymbols: false,
  );
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Image.asset(
            'images/logosplash.png',
            height: 250,
          ),
          Form(
            key: _formKey,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: TextFormField(
                        controller: nameController,
                        //controller: emailComtroller,
                        maxLines: 1,
                        enabled: false,
                        style: const TextStyle(
                            //color: Colors.black
                            ),
                        decoration: InputDecoration(
                          //fillColor: Colors.white,
                          hintText: 'Full Name',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.black),
                          hintStyle: const TextStyle(color: Colors.black87),
                          contentPadding: const EdgeInsets.only(left: 30),
                          border: myinputborder(),
                          enabledBorder: myinputborder(),
                          // OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.white,width: 3),
                          //     borderRadius: BorderRadius.circular(30),),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: TextFormField(
                        controller: emailController,
                        //maxLines: 1,
                        style: const TextStyle(
                            //color: Colors.black

                            ),
                        enabled: false,
                        //  initialValue: widget.email,
                        decoration: InputDecoration(
                          //fillColor: Colors.white,
                          hintText: 'Email Address',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.black),

                          hintStyle: const TextStyle(color: Colors.black87),
                          contentPadding: const EdgeInsets.only(left: 30),
                          border: myinputborder(),
                          enabledBorder: myinputborder(),
                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        //   controller: emailComtroller,
                        controller: phoneController,
                        //maxLines: 1,
                        style: const TextStyle(
                            //color: Colors.black
                            ),
                        decoration: InputDecoration(
                          //fillColor: Colors.white,
                          hintText: 'Phone Number',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.phone, color: Colors.black),
                          hintStyle: const TextStyle(color: Colors.black87),
                          contentPadding: const EdgeInsets.only(left: 30),
                          border: myinputborder(),
                          enabledBorder: myinputborder(),
                          // OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.white,width: 3),
                          //     borderRadius: BorderRadius.circular(30),),
                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      // decoration: BoxDecoration(
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Colors.grey.withOpacity(0.4),
                      //       spreadRadius: 2,
                      //       blurRadius: 8,
                      //     ),
                      //   ],
                      // ),
                      child: TextFormField(
                        controller: addressController,
                        //maxLines: 1,
                        style: const TextStyle(
                            //color: Colors.black
                            ),
                        decoration: InputDecoration(
                          //fillColor: Colors.white,
                          hintText: 'Address',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.location_on_outlined,
                              color: Colors.black),
                          hintStyle: const TextStyle(color: Colors.black87),
                          contentPadding: const EdgeInsets.only(left: 30),
                          border: myinputborder(),
                          enabledBorder: myinputborder(),
                          // OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.white,width: 3),
                          //     borderRadius: BorderRadius.circular(30),),
                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        // onChanged: (val) {
                        //
                        // },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Container(
                        height: height * 0.075,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(width * 0.2)),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                            style: BorderStyle.solid,
                          ),
                        ),
                        // color: Colors.green,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              createUser();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            backgroundColor: const Color(0xffFCD917),
                            elevation: width * 0.03,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.1),
                              // <-- Radius
                            ),
                          ),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: width * 0.05,
                              letterSpacing: width * 0.002,
                              // color: Colors.black,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> createUser() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = json.encode({
      "probono": "probono",
      "covered_area": "covered_area",
      "profession": "profession",
      "gender": "male",
      "age": 40,
      "email": widget.email,
      "user_type": widget.type.toString(),
      "password": widget.social_id.toString(),
      "name": widget.name,
      "contact_number": phoneController.text,
      "address": addressController.text,
      "social_id": widget.social_id,
      "link_type": widget.type,
      "city_id": 200,
    });
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/register_social_customer'),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      //print(data['description']);
      if (data['code'] == 0 || data["code"] == 5) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyApp()));
      } else {
        Get.snackbar(
          "Account Registeration",
          data["description"],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(8),
          snackStyle: SnackStyle.FLOATING,
        );
        //  Utils().toastMessage(data['description'].toString());
      }
    } else {
      print(response.body);
    }
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
    //Outline border type for TextFeild
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(
      color: Color(0xffFCD917),
      width: 1,
    ),
  );
}
