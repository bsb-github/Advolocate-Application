import 'dart:convert';
import 'package:advolocate_app/Model/AdvocatesData.dart';
import 'package:advolocate_app/Model/FacebookLoginData.dart';
import 'package:advolocate_app/Model/profile_data_model.dart';
import 'package:advolocate_app/Providers/ConfigProviders.dart';
import 'package:advolocate_app/Providers/ImageUrlProvider.dart';
import 'package:advolocate_app/Providers/LawyerDataProvider.dart';
import 'package:advolocate_app/Providers/OtpProvider.dart';
import 'package:advolocate_app/firebase_options.dart';
import 'package:advolocate_app/loginscreens/SelectionBottomScreens.dart';
import 'package:advolocate_app/loginscreens/manuallogin.dart';
import 'package:advolocate_app/loginscreens/splash.dart';
import 'package:advolocate_app/screens/AdvocateHomePage.dart';
import 'package:advolocate_app/screens/HomePage.dart';
import 'package:advolocate_app/screens/ProfilePending.dart';
import 'package:advolocate_app/screens/cso_laws.dart';
import 'package:advolocate_app/screens/homepage.dart';
import 'package:advolocate_app/screens/privacy_policy.dart';
import 'package:advolocate_app/screens/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_button.dart';
import 'loginscreens/selection.dart';
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

  runApp(ExcludeSemantics(child: MainEntryPoint()));
}

class MainEntryPoint extends StatelessWidget {
  const MainEntryPoint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigProvider()),
        ChangeNotifierProvider(create: (_) => ImageUrlProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(
          create: (_) => LawyerDataProvider(),
        )
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xffFCD917),
        ),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/profile': (context) => const UserProfile(),
          '/privacy_policy': (context) => const PrivacyPolicy(),
          '/cso_lawws': (context) => const CsoLaws(),
          //
        },
        // home: const SignUpScreen(),
        home: splashscreen(),
        builder: EasyLoading.init(),
        //  home: CreateUserAccount(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
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

  Future<void> loginGoogleUser(
    BuildContext context, {
    required int type,
    required String password,
    required GoogleSignInAccount acc
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var body = json.encode({"social_id": password, "link_type": type});
    var response = await http.post(
        Uri.parse('https://www.advolocate.info/api/login_social_customer'),
        headers: headers,
        body: body);
    print(response.body);

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
        EasyLoading.dismiss();
        Get.snackbar(
          "Account Registeration",
          data["description"],
          backgroundColor: Colors.green,
          snackStyle: SnackStyle.FLOATING,
        );
        setState(() {
          prefs.setString('email', password);
          prefs.setString('password', password);
          prefs.setString("loginType", "google");
          prefs.setString('token', data['result']['token'].toString());
          prefs.setInt('userId', data['result']['user_id']);
        });
        AdvocatesList.data.clear();
        getAdvocatesData();
        getUserData(
            1, data['result']['token'].toString(), data['result']['user_id']);
      } else if (data["description"] == "Please register your account") {
        EasyLoading.dismiss();
        showModalBottomSheet(
          context: context,
          builder: (context) => SelectionBottomScreen(
              name: acc.displayName.toString(),
              social_id: password,
              type: type,
              email: acc.email),
        );
        Get.snackbar(
          "Account Registeration",
          data["description"],
          backgroundColor: Colors.red,
          snackStyle: SnackStyle.FLOATING,
        );

        //Utils().toastMessage(data['description']);
      } else {
        EasyLoading.showError(data["description"]);
        EasyLoading.dismiss();

        Get.snackbar(
          "Account Registeration",
          data["description"],
          backgroundColor: Colors.red,
          snackStyle: SnackStyle.FLOATING,
        );
        print(response.body);
      }
    } else {
      EasyLoading.dismiss();
      Get.snackbar(
        "Account Registeration",
        "Cant Create Account (Check Your Internet Connection)",
        backgroundColor: Colors.red,
        snackStyle: SnackStyle.FLOATING,
      );
    }
  }

  Future<void> getUserData(int userType, String token, id) async {
    var url = Uri.parse('https://www.advolocate.info/api/getCustomerInfo');

    print('get data token');
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
    var advData = AdvocatesList.data.where(
      (element) => element.email == ProfileDataList.users[0].email,
    );
    print(ProfileDataList.users[0].email);
    if (ProfileDataList.users[0].profession == "profession" ||
        ProfileDataList.users[0].profession == "123") {
      EasyLoading.showSuccess("Login Success");
      EasyLoading.dismiss();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (advData.first.status >= 1) {
      context.read<LawyerDataProvider>().setAdvData(advData.first);
      EasyLoading.dismiss();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdvocateHomePage(),
          ));
      // push to advocate home
      // AdvocateResult result = AdvocateResult.fromJson(Provider.of<LawyerDataProvider>(context, listen: false).data.result);
    } else {
      EasyLoading.dismiss();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePending(),
          ));
    }
  }

  void getAdvocatesData() async {
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

  _logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  GoogleSignIn googleSignIn = GoogleSignIn();
  _login() async {
    print(200);
    final LoginResult result = await FacebookAuth.instance.login();

    print(1);
    EasyLoading.show();
    print(result.message);
    print(result.status);
    if (result.status == LoginStatus.success) {
      print("Success");
      _accessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      print(userData);

      //   var Data = jsonEncode(userData);


      FacebookData.data[0] = FaceBookLoginData.fromJson(userData);
      setState(() {});
      var data = FacebookData.data[0];
      print(3);
   //    getAdvocatesData();
   //    var Data = AdvocatesList.data.where(
   //      (element) => element.email == data.email,
   //    );
   // //   print(Data);
   //    print("API  DAta" + Data.first.email);
   //    if (Data.isEmpty) {
   //      EasyLoading.dismiss();
   //      showModalBottomSheet(
   //        context: context,
   //        builder: (context) => SelectionBottomScreen(
   //            name: data.name.toString(),
   //            social_id: data.id.toString(),
   //            type: 2,
   //            email: data.email.toString()),
   //      );
   //    } else {
//        EasyLoading.dismiss();

        // loginGoogleUser(context,
        //     type: 2, password: FacebookData.data[0].id.toString());
      }

      setState(() {
        loading = false;
      });

    //   print(020);
  }

  googleLogin() async {
      print("googleLogin Called");
      var reslut = await googleSignIn.signIn();
      print(reslut);
      EasyLoading.show();
      print(1);
      setState(() {
        loading = false;
      });

      if (reslut == null) {
        print("error");
      return;
      }
      // ignore: use_build_context_synchronously
      getAdvocatesData();
      var Data = AdvocatesList.data.where(
        (element) => element.email == reslut.email,
      );
      print("sasdfghjkoll");
      //print("A~PI  DAta" + Data.first.email);g
      googleSignIn.disconnect();
        loginGoogleUser(context, type: 1, password: reslut.id, acc: reslut);


  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ExcludeSemantics(
      child: SafeArea(
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
                     // _login();
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
      ),
    );
  }
}
