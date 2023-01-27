import 'dart:convert';

import 'package:advolocate_app/Model/FacebookLoginData.dart';
import 'package:advolocate_app/Model/profile_data_model.dart';
import 'package:advolocate_app/Model/searchResultModel.dart';
import 'package:advolocate_app/Providers/ConfigProviders.dart';
import 'package:advolocate_app/Providers/ImageUrlProvider.dart';
import 'package:advolocate_app/Providers/OtpProvider.dart';
import 'package:advolocate_app/firebase_options.dart';
import 'package:advolocate_app/home.dart';
import 'package:advolocate_app/loginscreens/createadvocate.dart';
import 'package:advolocate_app/loginscreens/manuallogin.dart';
import 'package:advolocate_app/loginscreens/splash.dart';
import 'package:advolocate_app/screens/cso_laws.dart';
import 'package:advolocate_app/screens/homepage.dart';
import 'package:advolocate_app/screens/lawyer_page.dart';
import 'package:advolocate_app/screens/privacy_policy.dart';
import 'package:advolocate_app/screens/search_results.dart';
import 'package:advolocate_app/screens/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/registerCustomer_api.dart';
import 'custom_button.dart';
import 'loginscreens/selection.dart';
import 'loginscreens/signup.dart';
import 'package:http/http.dart' as http;

import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isNotEmpty) {
    await Firebase.initializeApp(
        name: "advolocate1234567",
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp(
        name: "advolocate1234567",
        options: DefaultFirebaseOptions.currentPlatform);
    Firebase.app();
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ConfigProvider()),
      ChangeNotifierProvider(create: (_) => ImageUrlProvider()),
      ChangeNotifierProvider(create: (_) => OtpProvider()),
    ],
    child: MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffFCD917),
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const UserProfile(),
        '/privacy_policy': (context) => const PrivacyPolicy(),
        '/cso_laws': (context) => const CsoLaws(),
        '/result_page': (context) => ResultPage(),
      },
      // home: const SignUpScreen(),
      home: splashscreen(),
      //  home: CreateUserAccount(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool loading = false;

  // _fblogin() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   final LoginResult loginResult =
  //       await FacebookAuth.instance.login(permissions: [
  //     'email',
  //     'public_profile',
  //   ]);

  //   // Create a credential from the access token
  //   // final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //   print('printing result');
  //   print(result.status);
  //   setState(() {
  //     loading = false;
  //   });
  //   if (result.status == LoginStatus.success) {
  //     _accessToken = result.accessToken;
  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(result.accessToken!.token);
  //     FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //     final userData = await FacebookAuth.instance.getUserData();
  //     _userData = userData;
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const home(),
  //         ));
  //   } else {
  //     print(result.status);
  //     print(result.message);
  //   }
  // }

  // _login() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   final LoginResult loginResult =
  //       await FacebookAuth.instance.login(permissions: [
  //     'email',
  //     'public_profile',
  //   ]);

  //   // Create a credential from the access token
  //   // final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //   print('printing result');
  //   print(result.status);
  //   setState(() {
  //     loading = false;
  //   });
  //   if (result.status == LoginStatus.success) {
  //     _accessToken = result.accessToken;
  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(result.accessToken!.token);
  //     FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //     final userData = await FacebookAuth.instance.getUserData();
  //     print(userData);
  //     _userData = userData;
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const home(),
  //         ));
  //   } else {
  //     print(result.status);
  //     print(result.message);
  //   }
  // }
  _checkIfidLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      loading = false;
    });

    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      print(userData);
      _accessToken = accessToken;
      print(userData);
      setState(() {
        _userData = userData;
      });
    } else {
      print(1);
      _login();
    }
  }

  _login() async {
    print(200);
    final LoginResult result = await FacebookAuth.instance.login();
    //_logout();
    //_checkIfidLoggedIn();
    print(result.message);
    print(result.status);
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      //var data = jsonEncode(userData);

      print(userData);

      FacebookData.data[0] = FaceBookLoginData.fromJson(userData);
      setState(() {});
      print(3);
      addFBUserData();
      setState(() {
        loading = false;
      });
    }
    //   print(020);
  }

  Future<void> createUser() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var data = FacebookData.data[0];
    print(data.id);
    print(data.email);

    var body = json.encode({
      "email": data.email,
      "user_type": 1,
      "password": data.id,
      "name": data.name,
      //   "img_url": data.imageUrl,
      "contact_number": data.id,
      "social_id": data.id,
      'address': "",
      "link_type": 2,
      "city_name": "Advolocate App"
    });
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/register_social_customer'),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      print(data['description']);
      if (data['code'] == 0 || data['code'] == 5) {
        loginGoogleUser(context,
            type: 2, password: FacebookData.data[0].id.toString());
      } else {
        //   await createuser(
        //       FacebookData.data[0].email.toString(),
        //       2,
        //       FacebookData.data[0].id.toString(),
        //       FacebookData.data[0].name.toString(),
        //       "Advolocate App",
        //       2);
        // }
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  // void LoginFacebookUser(BuildContext context,
  //     {required String email, required String password}) async {
  //   print(4);
  //   var headers = {
  //     'Content-Type': 'application/json',
  //   };

  //   var body = json.encode({"social_id": password, "link_type": 2});
  //   var response = await http.post(
  //       Uri.parse('http://www.advolocate.info/api/login_social_customer'),
  //       headers: headers,
  //       body: body);
  //   print(5);
  //   print(response.body);
  //   final prefs = await SharedPreferences.getInstance();
  //   if (response.statusCode == 200) {
  //     print(6);
  //     var data = jsonDecode(response.body.toString());

  //     print(data['description']);
  //     if (data['description'].toString() ==
  //         'please check give correct email and password') {
  //       //  await signupUser(email, password);

  //       print(8);
  //     } else if (data['description'].toString() == 'login Successful') {
  //       print(9);
  //       Provider.of<ConfigProvider>(context, listen: false)
  //           .setToken(data['result']['token']);
  //       Provider.of<ConfigProvider>(context, listen: false)
  //           .setUserID(data['result']['user_id']);

  //       setState(() {
  //         prefs.setString('email', email);
  //         prefs.setString('password', password);
  //         prefs.setString("loginType", "fb");
  //         prefs.setString('token', data['result']['token'].toString());
  //         prefs.setInt('userId', data['result']['user_id']);
  //       });
  //       _logout();
  //       Navigator.pushNamed(context, '/home');
  //     } else {
  //       print(7);
  //       print("In crfeating");
  //       createuser(
  //           FacebookData.data[0].email.toString(),
  //           2,
  //           FacebookData.data[0].id.toString(),
  //           FacebookData.data[0].name.toString(),
  //           "Advolocate App",
  //           2);
  //     }
  //   }
  // }

  Future<void> createuser(String email, int userType, String id, String name,
      String address, int type) async {
    //_logout();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var body = json.encode({
      "email": email,
      "user_type": type,
      "password": id,
      "name": name,
      "contact_number": "01",
      //   "img_url": data.imageUrl,
      "social_id": id,
      'address': address,
      "link_type": type,
      "city_name": address,
    });
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/register_social_customer'),
        headers: headers,
        body: body);
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      print(data);
      print(data['description']);
      if (data['code'] == 0 || data['code'] == 5) {
        print(0);
        if (type == 1) {
          loginGoogleUser(
            context,
            type: 1,
            password: id,
          );
        } else {
          loginGoogleUser(context, type: type, password: id);
        }
      } else {
        Utils().toastMessage(data['description'].toString());
      }
    } else {
      print(-1);
      print(data['description']);
      print(response.body);
    }
  }

  Future<void> createFBUser(String email, int userType, String id, String name,
      String address, int type) async {
    //_logout();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var body = json.encode({
      "email": email,
      "user_type": type,
      "password": id,
      "name": name,
      "contact_number": "01",
      //   "img_url": data.imageUrl,
      "social_id": id,
      'address': address,
      "link_type": type,
      "city_name": address,
    });
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/register_social_customer'),
        headers: headers,
        body: body);
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      print(data);
      print(data['description']);
      if (data['code'] == 0 || data['code'] == 5) {
        print(0);

        loginGoogleUser(context, type: type, password: id);
      } else {
        Utils().toastMessage(data['description'].toString());
      }
    } else {
      print(-1);
      print(data['description']);
      print(response.body);
    }
  }

  Future<void> loginGoogleUser(BuildContext context,
      {required int type, required String password}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    print(password);
    var body = json.encode({"social_id": password, "link_type": type});
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/login_social_customer'),
        headers: headers,
        body: body);

    final prefs = await SharedPreferences.getInstance();
    print("status code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      print(data['description']);
      if (data['description'].toString() ==
              'please check give correct email and password' ||
          data['result'] == null) {
        Utils().toastMessage('please check give correct email and password');
      } else if (data['description'].toString() == 'Login Successful') {
        print(data['result']['token']);

        Provider.of<ConfigProvider>(context, listen: false)
            .setToken(data['result']['token']);
        Provider.of<ConfigProvider>(context, listen: false)
            .setUserID(data['result']['user_id']);

        setState(() {
          prefs.setString('email', password);
          prefs.setString('password', password);
          prefs.setString("loginType", "google");
          prefs.setString('token', data['result']['token'].toString());
          prefs.setInt('userId', data['result']['user_id']);
        });
        if (type == 1) {
          googleSignIn.disconnect();
        } else {
          _logout();
        }

        Navigator.pushNamed(context, '/home');
      } else if (data["description"] == "Please register your account") {
        Utils().toastMessage("Sign in methods " + data['description']);
        await createFBUser(
            FacebookData.data[0].email.toString(),
            2,
            FacebookData.data[0].id.toString(),
            FacebookData.data[0].name.toString(),
            "Advolocate App",
            2);
      } else {
        Utils().toastMessage(response.body);
        print(response.body);
      }
    } else {
      Utils().toastMessage(response.body);
      print(response.body);
    }
  }

  _logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  GoogleSignIn googleSignIn = GoogleSignIn();

  googleLogin() async {
    setState(() {
      loading = true;
    });
    print("googleLogin method Called");

    try {
      var reslut = await googleSignIn.signIn();

      setState(() {
        loading = false;
      });

      if (reslut == null) {
        //  googleSignIn.disconnect();
        return;
      }
      // ignore: use_build_context_synchronously
      addGoogleUserData(data: reslut);
    } catch (error) {
      print(error);
      setState(() {
        loading = false;
      });
    }
  }

  void loginUser(BuildContext context,
      {required String email,
      required String password,
      required GoogleSignInAccount reslut}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = json.encode({"social_id": password, "link_type": 1});
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
        print(reslut.email);
        print(reslut.id);

        //await signupUser(reslut.email, reslut.id);
        await createuser(reslut.email, 1, reslut.id,
            reslut.displayName.toString(), "Hello", 1);
      } else if (data['description'].toString() == 'Login Successful') {
        print(data['result']['token']);
        Provider.of<ConfigProvider>(context, listen: false)
            .setToken(data['result']['token']);
        Provider.of<ConfigProvider>(context, listen: false)
            .setUserID(data['result']['user_id']);

        setState(() {
          prefs.setString('email', email);
          prefs.setString('password', password);
          prefs.setString('token', data['result']['token'].toString());
          prefs.setInt('userId', data['result']['user_id']);
          prefs.setString("loginType", "google");
        });
        // googleSignIn.disconnect();
        Navigator.pushNamed(context, '/home');
      } else {
        // await createuser(reslut.email, 1, reslut.id,
        //     reslut.displayName.toString(), "Hello", 1);
      }
    }
  }

  void addGoogleUserData({required GoogleSignInAccount data}) async {
    final prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance.collection("user").doc(data.id).set({
      "email": data.email,
      "user_type": 1,
      "password": data.id,
      "name": data.displayName,
      "contact_number": "01",
      //   "img_url": data.imageUrl,
      "social_id": data.id,
      'address': "Pakistan",
      "link_type": 1,
      "city_name": "KArachi",
    }).then((value) {
      setState(() {
        prefs.setString('email', data.email);
        prefs.setString('password', data.id);
        prefs.setString('token', data.displayName.toString());
        prefs.setInt('userId', 2343);
        prefs.setString("loginType", "google");
      });
      getAdvoUserData();
      Navigator.pushNamed(context, '/home');
    });
  }

  void addFBUserData() async {
    var data = FacebookData.data[0];
    final prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance.collection("user").doc(data.id).set({
      "email": data.email,
      "user_type": 2,
      "password": data.id,
      "name": data.name,
      "contact_number": "01",
      //   "img_url": data.imageUrl,
      "social_id": data.id,
      'address': "Pakistan",
      "link_type": 2,
      "city_name": "KArachi",
    }).then((value) {
      setState(() {
        prefs.setString('email', data.email.toString());
        prefs.setString('password', data.id.toString());
        prefs.setString('token', data.name.toString());
        prefs.setInt('userId', 2343);
        prefs.setString("loginType", "google");
      });
      getAdvoUserData();
      Navigator.pushNamed(context, '/home');
    });
  }

  void getAdvoUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final String? id = prefs.getString('password');
    var data =
        await FirebaseFirestore.instance.collection("user").doc(id).get();
    ProfileDataList.users[0] = ProfileData.fromSnapshot(data);
    print(ProfileDataList.users[0].email);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.1),
              CustomImage(
                conheight: height * 0.3,
                conwidth: width * 0.7,
                Image: 'images/logosplash.png',
              ),
              Spacer(),
              SizedBox(height: height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    _login();
                  },
                  child: Container(
                    height: 55,
                    width: height * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xff4A7AD8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset("images/fb.png"),
                        Text(
                          "Login with Facebook",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    googleLogin();
                  },
                  child: Container(
                    height: 55,
                    width: height * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xffDB2F2F),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset("images/google.png"),
                        Text(
                          "Login with Google",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ManualLoginScreen()));
                  },
                  child: Container(
                    height: 55,
                    width: height * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xff362F2F),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset("images/person.png"),
                        Text(
                          "Login Manually",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.only(left: width * 0.3),
                child: Row(
                  children: [
                    Text(
                      "Don't have account?",
                      style: TextStyle(
                          fontSize: width * 0.04, wordSpacing: width * 0.002),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SelectionScreen(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
