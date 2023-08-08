import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:advolocate_app/Model/profile_data_model.dart';
import 'package:advolocate_app/loginscreens/createadvocate.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/HomePages.dart';

class UpdateBottomSheet extends StatefulWidget {
  final String name;
  final String contact_number;
  final String address;
  final String city;
  final String email;
  const UpdateBottomSheet(
      {super.key,
      required this.name,
      required this.contact_number,
      required this.address,
      required this.city,
      required this.email});

  @override
  State<UpdateBottomSheet> createState() => _UpdateBottomSheetState();
}

class _UpdateBottomSheetState extends State<UpdateBottomSheet> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  var data = ProfileDataList.users[0];
  @override
  void initState() {
    // TODO: implement initState
    nameController.text = widget.name;
    emailController.text = widget.email;
    phoneController.text = widget.contact_number;
    addressController.text = widget.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Semantics(
      label: "User Data Update",
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Update Data',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
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
                      prefixIcon: const Icon(Icons.person, color: Colors.black),
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
                  margin:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
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
                      enabled: false,
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.email, color: Colors.black),

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
                  margin:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: TextFormField(
                    controller: addressController,
                    //maxLines: 1,
                    style: const TextStyle(
                        //color: Colors.black

                        ),
                    enabled: true,
                    //  initialValue: widget.email,
                    decoration: InputDecoration(
                      //fillColor: Colors.white,
                      hintText: 'Address',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.home, color: Colors.black),

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
                  margin:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: TextFormField(
                    controller: passwordController,
                    //maxLines: 1,
                    style: const TextStyle(
                        //color: Colors.black

                        ),
                    enabled: true,
                    //  initialValue: widget.email,
                    decoration: InputDecoration(
                      //fillColor: Colors.white,
                      hintText: 'City',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.place, color: Colors.black),

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
                  margin:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: TextFormField(
                    controller: phoneController,
                    //maxLines: 1,
                    style: const TextStyle(
                        //color: Colors.black

                        ),
                    enabled: true,
                    //  initialValue: widget.email,
                    decoration: InputDecoration(
                      //fillColor: Colors.white,
                      hintText: 'Phone Number',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.phone, color: Colors.black),

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
                        final prefs = await SharedPreferences.getInstance();

                        final String? token = prefs.getString('token');
                        final int? userId = prefs.getInt('userId');
                        var headers = {
                          'Content-Type': 'application/json',
                          'Accept': 'application/json',
                          'Authorization': 'Bearer ${token}',
                        };
                        print('Bearer ${token}');
                        print(userId);
                        var body = jsonEncode({
                          "user_id": userId,
                          "name": nameController.text,
                          "contact_number": phoneController.text,
                          "email": emailController.text,
                          "address": addressController.text,
                          "selectedCountry": 1,
                          "img_url":
                              "data:image/jpeg;base64,'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
                        });
                        var response = await http.post(
                            Uri.parse(
                                'https://www.advolocate.info/api/updateCustomerInfo'),
                            headers: headers,
                            body: body);
                        var data = jsonDecode(response.body);

                        print(response.body);
                        if (data["description"] != "Unable  to update data") {
                          getUserData(1, token!, userId);
                        } else {
                          print(response.body);
                        }
                        //  if (_formKey.currentState!.validate()) {

                        //}
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
                        'Update',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: width * 0.05,
                          letterSpacing: width * 0.002,
                          // color: Colors.black,
                        ),
                      ),
                    )),
              ],
            ),
          )),
    );
  }

  Future<void> getUserData(int userType, String token, id) async {
    var url = Uri.parse('https://www.advolocate.info/api/getCustomerInfo');

    print(token);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.post(url,
        body: jsonEncode({"user_id": id}), headers: headers);
    var data = jsonDecode(response.body.toString());
    print(data);
    ProfileDataList.users[0] = ProfileData.fromJson(data['result']);
    print(ProfileDataList.users[0].email);
    if (userType == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      // AdvocateResult result = AdvocateResult.fromJson(Provider.of<LawyerDataProvider>(context, listen: false).data.result);

      // ignore: use_build_context_synchronously
    }
  }
}
