import 'package:advolocate_app/Model/AdvocatesData.dart';
import 'package:advolocate_app/Providers/OtpProvider.dart';
import 'package:advolocate_app/loginscreens/manuallogin.dart';
import 'package:advolocate_app/loginscreens/verificationpassword.dart';
import 'dart:convert';
import 'package:advolocate_app/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class CreateUserAccount extends StatefulWidget {
  final String email;
  final String password;
  const CreateUserAccount(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<CreateUserAccount> createState() => _CreateUserAccountState();
}

class _CreateUserAccountState extends State<CreateUserAccount> {
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
    passwordController.text = widget.password;
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
                      padding: const EdgeInsets.only(left: 18.0),
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
                      height: 12,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: TextFormField(
                        controller: nameController,
                        //controller: emailComtroller,
                        maxLines: 1,
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
                      height: height * 0.03,
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
                        enabled: true,
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
                      height: height * 0.03,
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
                        controller: passwordController,
                        //maxLines: 1,
                        obscureText: true,
                        style: const TextStyle(
                            //color: Colors.black
                            ),
                        // initialValue: widget.,
                        decoration: InputDecoration(
                          //fillColor: Colors.white,
                          hintText: 'Password',
                          fillColor: Colors.white,
                          filled: true,

                          prefixIcon:
                              const Icon(Icons.password, color: Colors.black),
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
                      height: height * 0.03,
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
                      height: height * 0.03,
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
                      height: height * 0.03,
                    ),
                    Container(
                        height: height * 0.075,
                        width: width * 0.70,
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
                              var data = AdvocatesList.data.where((element) =>
                                  element.email == emailController.text);

                              var header = {
                                "Content-Type": "application/json",
                              };

                              var emailJS = Uri.parse(
                                  "https://api.emailjs.com/api/v1.0/email/send");

                              String code = otpGenerator.generate();
                              Provider.of<OtpProvider>(context, listen: false)
                                  .setOTP(code);
                              if (data.isEmpty) {
                                var response = await http.post(emailJS,
                                    headers: header,
                                    body: json.encode({
                                      "service_id": "service_y0qy9wf",
                                      "template_id": "template_lk61b4l",
                                      "user_id": "DUuUd1QWscbZpx6yJ",
                                      "template_params": {
                                        "to_name": nameController.text,
                                        "otp_code": code,
                                        "subject":
                                            "OTP For the Application Advolocate",
                                        "user_email": emailController.text,
                                      }
                                    }));
                                print(response.reasonPhrase);
                                // var data = jsonDecode(response.body);
                                // print(data);
                                print(response.body);
                                if (response.statusCode == 200) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PasswordVerify(
                                                type: '1',
                                                address: addressController.text,
                                                password:
                                                    passwordController.text,
                                                phone: phoneController.text,
                                                otp: code,
                                                email: emailController.text,
                                                name: nameController.text,
                                              )));
                                } else {
                                  Get.snackbar(
                                      "Error", "check your Email and try again",
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: Colors.white,
                                      backgroundColor: Colors.red,
                                      margin: EdgeInsets.all(8));

                                  //print(response.body);
                                }
                              } else {
                                Get.snackbar("User Already have Account",
                                    "User Already Exist",
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red,
                                    margin: EdgeInsets.all(8));
                              }
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
}
