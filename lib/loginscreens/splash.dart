import 'dart:async';
import 'dart:convert';
import 'package:advolocate_app/Model/AdvocatesData.dart';
import 'package:advolocate_app/Model/adovacate_data_model.dart';
import 'package:advolocate_app/Providers/LawyerDataProvider.dart';
import 'package:advolocate_app/main.dart';
import 'package:advolocate_app/screens/AdvocateHomePage.dart';
import 'package:advolocate_app/screens/HomePage.dart';
import 'package:advolocate_app/screens/ProfilePending.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/profile_data_model.dart';
import '../Providers/ConfigProviders.dart';
import '../config.dart';
import 'package:http/http.dart' as http;
class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  // SplashServicees sp//lashscreen =SplashServicees();
  final dio = Dio();

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
    await getAdvocatesData();
    final prefs = await SharedPreferences.getInstance();

    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');
    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');
    final String? userType = prefs.getString("userType");

    if (email != null && password != null) {
      if (userType == null && token != "Bismillah Sharif Bhutta" ||
          userType == "manual") {
        getUserData(1, token!, userId);
      } else {
        if (userType == "0") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ProfilePending()));
        } else {
          Provider.of<LawyerDataProvider>(context, listen: false).setAdvData(
              AdvocatesList.data
                  .where((element) => element.email == email)
                  .first);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdvocateHomePage(),
              ));
        }
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyApp()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ExcludeSemantics(
      child: Scaffold(
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
      ),
    );
  }

  ProfileDataModel profileDataModel = ProfileDataModel();
  AdvocateData advocateData = AdvocateData();
  Future<void> getUserData(int userType, String token, id) async {
    var url = Uri.parse('https://www.advolocate.info/api/getCustomerInfo');

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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      // AdvocateResult result = AdvocateResult.fromJson(Provider.of<LawyerDataProvider>(context, listen: false).data.result);
    }
  }

  Future<void> getAdvocatesData() async {
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

  void loginUser(String email, String password) async {
    final auth = FirebaseAuth.instance;
    // auth.createUserWithEmailAndPassword(email: email, password: password);
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

