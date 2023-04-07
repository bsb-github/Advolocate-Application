import 'dart:convert';

import 'package:advolocate_app/Model/login_model.dart';
import 'package:advolocate_app/Providers/ConfigProviders.dart';
import 'package:advolocate_app/Providers/LawyerDataProvider.dart';
import 'package:advolocate_app/config.dart';
import 'package:advolocate_app/loginscreens/createuser.dart';
import 'package:advolocate_app/loginscreens/forgotpass.dart';
import 'package:advolocate_app/loginscreens/selection.dart';
import 'package:advolocate_app/loginscreens/signup.dart';
import 'package:advolocate_app/screens/AdvocateHomePage.dart';
import 'package:advolocate_app/screens/ProfilePending.dart';
import 'package:advolocate_app/screens/homepage.dart';
import 'package:advolocate_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/AdvocatesData.dart';
import '../Model/profile_data_model.dart';
import '../screens/HomePage.dart';

class ManualLoginScreen extends StatefulWidget {
  const ManualLoginScreen({Key? key}) : super(key: key);

  @override
  State<ManualLoginScreen> createState() => _ManualLoginScreenState();
}

class _ManualLoginScreenState extends State<ManualLoginScreen> {
  bool _isObscure = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailComtroller = TextEditingController();
  final passwordComtroller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailComtroller.dispose();
    passwordComtroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ExcludeSemantics(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Image.asset(
                'images/logosplash.png',
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Form(
                  key: _formKey,
                  child: ExcludeSemantics(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Get started here',
                              style: TextStyle(
                                fontSize: width * 0.05,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: emailComtroller,
                                  maxLines: 1,

                                  style: const TextStyle(

                                      //color: Colors.black
                                      ),
                                  decoration: InputDecoration(
                                    //fillColor: Colors.white,
                                    hintText: 'Email',
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(Icons.email_outlined,
                                        color: Colors.black),
                                    hintStyle:
                                        const TextStyle(color: Colors.black87),
                                    contentPadding:
                                        const EdgeInsets.only(left: 30),
                                    border: myinputborder(),
                                    enabledBorder: myinputborder(),
                                  ),

                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email is required';
                                    }
                                    return null;
                                  },
                                  // onChanged: (val) {
                                  //
                                  // },
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: passwordComtroller,
                                  maxLines: 1,
                                  obscureText: _isObscure,
                                  style: const TextStyle(
                                      //color: Colors.black
                                      ),

                                  decoration: InputDecoration(
                                    //fillColor: Colors.white,
                                    // hintText: '●●●●●●',
                                    hintText: 'Enter Password',
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Colors.black),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                      icon: Icon(_isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    hintStyle: const TextStyle(
                                      color: Colors.black87,
                                      // Colors.grey,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(left: 30),
                                    border: myinputborder(),
                                    enabledBorder: myinputborder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                  // onChanged: (value) {
                                  //   // do something
                                  // },
                                ),
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(right: width*0.45),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PasswordForgotScreen(),
                                      ));
                                },
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    color: const Color(0xffFCD917),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          Container(
                              height: 60,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                                    loginUser(
                                        email: emailComtroller.text,
                                        password: passwordComtroller.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.black,
                                  backgroundColor: const Color(0xffFCD917),
                                  elevation: width * 0.03,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.1),
                                    // <-- Radius
                                  ),
                                ),
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: width * 0.05,
                                    letterSpacing: width * 0.002,
                                    //color: Colors.black,
                                  ),
                                ),
                              )),
                          // const Spacer(),
                          SizedBox(
                            height: 72,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have account?",
                                style: TextStyle(
                                    fontSize: width * 0.04,
                                    wordSpacing: width * 0.002),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SelectionScreen(),
                                        ));
                                  },
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                        color: const Color(0xffFCD917),
                                        fontSize: width * 0.04),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser({
    required String email,
    required String password,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = json.encode({"email": email, "password": password});
    var response = await http.post(
        Uri.parse('https://www.advolocate.info/api/login'),
        headers: headers,
        body: body);

    final prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      print(data['description']);
      if (data['description'].toString() ==
              'please check give correct email and password' ||
          data['result'] == null) {
        Utils().toastMessage('please check give correct email and password');
      } else if (data['description'].toString() == 'login Successful' ||
          data['result'] != null) {
        print(data['result']['token']);

        prefs.setString('email', email);
        prefs.setString('password', password);
        prefs.setString('token', data['result']['token'].toString());
        prefs.setInt('userId', data['result']['user_id']);

        // getUserData(
        //     1, data['result']['token'].toString(), data['result']['user_id']);
        await getAdvocatesData();
        setState(() {});
        var Data = AdvocatesList.data
            .where((element) => element.email == emailComtroller.text);
        //  print(Data.first.profession);
        //print(Data.first.status);
        if (Data.isEmpty) {
          prefs.setString("userType", "manual");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (Data.first.status == 0) {
          prefs.setString("userType", Data.first.status.toString());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfilePending()));
        } else if (Data.first.status == 1) {
          prefs.setString("userType", Data.first.status.toString());
          Provider.of<LawyerDataProvider>(context, listen: false)
              .setAdvData(Data.first);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdvocateHomePage(),
              ));
          // Navigate if advocate is authenticated to deal
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> getAdvocatesData() async {
    AdvocatesList.data.clear();
    var response = await http
        .post(Uri.parse("https://www.advolocate.info/api/getAdvocatesData"));
    print(response.body);
    var data = jsonDecode(response.body);
    var advos = List.from(data["result"]);

    for (var i = 0; i < advos.length; i++) {
      AdvocatesList.data.add(AdvocatesData.fromJson(advos[i]));
    }

    print(AdvocatesList.data[34].email);
  }

  // Future<void> getUserData(int userType, String token, id) async {
  //   var url = Uri.parse('http://www.advolocate.info/api/getCustomerInfo');

  //   print('get data token');
  //   var getCustomerInfoToken =
  //       Provider.of<ConfigProvider>(context, listen: false).token;
  //   print(token);
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${token}',
  //   };
  //   var response = await http.post(url,
  //       body: jsonEncode({"user_id": id}), headers: headers);
  //   var data = jsonDecode(response.body.toString());
  //   print(data);
  //   ProfileDataList.users[0] = ProfileData.fromJson(data['result']);
  //   print(ProfileDataList.users[0].email);
  //   if (userType == 1) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => HomePage()));
  //   } else {
  //     // AdvocateResult result = AdvocateResult.fromJson(Provider.of<LawyerDataProvider>(context, listen: false).data.result);

  //   }
  // }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
    //Outline border type for TextFeild
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(
      color: Color(0xffFCD917),
      width: 1,
    ),
  );
}
