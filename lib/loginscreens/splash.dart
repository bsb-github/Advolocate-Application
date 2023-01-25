import 'dart:async';
import 'dart:convert';

import 'package:advolocate_app/Model/adovacate_data_model.dart';
import 'package:advolocate_app/Providers/LawyerDataProvider.dart';
import 'package:advolocate_app/home.dart';
import 'package:advolocate_app/main.dart';
import 'package:advolocate_app/screens/HomePage.dart';
import 'package:advolocate_app/screens/homepage.dart';
import 'package:advolocate_app/screens/lawyer_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/profile_data_model.dart';
import '../Providers/ConfigProviders.dart';
import '../config.dart';
import '../custom_button.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  // SplashServicees splashscreen =SplashServicees();
  @override
  initState() {
    super.initState();
    getData();
    // splashscreen.isLogin(context);
    // _navigatetopageview();
  }

  // _navigatetopageview()async{å
  //   await Future.delayed(Duration(seconds:3),(){});
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
  // }

  getData() async {
    final prefs = await SharedPreferences.getInstance();

    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');
    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');
    final String? userType = "manual";

    if (email != null && password != null) {
      if (userType == "manual") {
        getUserData(1, token!, userId);
      } else {
        getAdvoUserData(password);
      }
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyApp()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Opacity(
                // opacity: 0.2,
                // // With Background Image
                // child: Image(
                //   image: AssetImage(captainMarvel),
                //   height: 800.0,
                //   fit: BoxFit.fitHeight,
                // ),
                // With Background Color
                opacity: 0.8,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.black,
                        Colors.white,
                      ],
                    ),
                    // image: DecorationImage(
                    //   image: AssetImage('images/logosplash.png'),
                    //   opacity: 2,
                    // )
                  ),
                ),
              ),
              // CustomImage(
              //   conheight: height * 0.3,
              //   conwidth: width * 0.7,
              //   borderColor: Colors.transparent,
              //   Image: 'images/logosplash.png',
              // ),
              Image.asset(
                "images/logosplash.png",
                height: height * 0.3,
                width: width * 0.7,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
    );
  }

  ProfileDataModel profileDataModel = ProfileDataModel();
  AdvocateData advocateData = AdvocateData();
  Future<void> getUserData(int userType, String token, id) async {
    var url = Uri.parse('http://www.advolocate.info/api/getCustomerInfo');

    print('get data token');
    var getCustomerInfoToken =
        Provider.of<ConfigProvider>(context, listen: false).token;
    print(token);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}',
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LawyerPage(
                    address: profileDataModel.result!.address ?? "",
                    email: profileDataModel.result!.email ?? "",
                    information: profileDataModel.result!.contactNumber ?? '',
                    name: profileDataModel.result!.name ?? "",
                    probono: profileDataModel.result!.probono.toString(),
                  )));
    }
  }

  void loginUser(String email, String password) async {
    final auth = FirebaseAuth.instance;
    // auth.createUserWithEmailAndPassword(email: email, password: password);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = json.encode({"email": email, "password": password});
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/login'),
        headers: headers,
        body: body);

    final prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      if (data['description'].toString() == 'login Successful' ||
          data['result'] != null) {
        Provider.of<ConfigProvider>(context, listen: false)
            .setToken(data['result']['token']);
        Provider.of<ConfigProvider>(context, listen: false)
            .setUserID(data['result']['user_id']);
        setState(() {
          userID = data['result']['user_id'];
        });

        prefs.setString('token', data['result']['token'].toString());
        prefs.setInt('userId', data['result']['user_id']);
        //
        print(data);
        getUserData(1, data['result']['token'], data['result']['user_id']);
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MyApp()));
      }
    } else {
      print(response.reasonPhrase);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyApp()));
    }
  }

  void loginGoogleUser(BuildContext context,
      {required String social_id}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = json.encode({"social_id": social_id, "link_type": 1});
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/login_social_customer'),
        headers: headers,
        body: body);

    final prefs = await SharedPreferences.getInstance();
    var data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      print(data['description']);
      if (data['description'].toString() ==
              'please check give correct email and password' ||
          data['code'] == null) {
        // Utils().toastMessage('please check give correct email and password');
        //await signupUser(reslut.email, reslut.id);

      } else if (data['description'].toString() == 'login Successful') {
        Provider.of<ConfigProvider>(context, listen: false)
            .setToken(data['result']['token']);
        Provider.of<ConfigProvider>(context, listen: false)
            .setUserID(data['result']['user_id']);

        Navigator.pushNamed(context, '/home');
      }
    }
  }

  void loginFBUser(BuildContext context, {required String social_id}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = json.encode({"social_id": social_id, "link_type": 2});
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/login_social_customer'),
        headers: headers,
        body: body);

    var data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      print(data['description']);
      if (data['description'].toString() ==
              'please check give correct email and password' ||
          data['code'] == null) {
        // Utils().toastMessage('please check give correct email and password');
        //await signupUser(reslut.email, reslut.id);

      } else if (data['description'].toString() == 'login Successful') {
        // ignore: use_build_context_synchronously
        Provider.of<ConfigProvider>(context, listen: false)
            .setToken(data['result']['token']);
        // ignore: use_build_context_synchronously
        Provider.of<ConfigProvider>(context, listen: false)
            .setUserID(data['result']['user_id']);

        Navigator.pushNamed(context, '/home');
      }
    }
  }

  void getAdvoUserData(String id) async {
    var data =
        await FirebaseFirestore.instance.collection("user").doc(id).get();
    ProfileDataList.users[0] = ProfileData.fromSnapshot(data);

    // ProfileDataModel.fromJson(jsonDecode(data.toString()));
    print(ProfileDataList.users[0].email);
    Navigator.pushNamed(context, '/home');
  }
}

//
// class SplashServicees {
//   void isLogin(BuildContext context){
//     final auth= FirebaseAuth.instance;
//     final user= auth.currentUser;
//     if(user!= null){
//       Timer(const Duration(seconds: 3),()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const home())));
//     }
//     else{
//       Timer(const Duration(seconds: 3),()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyApp())));
//     }
//      }
// }
