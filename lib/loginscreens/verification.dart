import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:advolocate_app/Providers/OtpProvider.dart';
import 'package:advolocate_app/loginscreens/resetpassword.dart';
import 'package:advolocate_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:random_string_generator/random_string_generator.dart';
import '../custom_button.dart';
import 'package:http/http.dart' as http;

import 'manuallogin.dart';

class AdvocateEmailVerify extends StatefulWidget {
  final String type;
  final String email;
  final String name;
  final String otp;
  final String phone;
  final String password;
  final String address;
  final String profession;
  final String age;
  final String coveredArea;
  final String regions;
  final String country;
  final String city;
  final String probono;
  final String fOfServices;
  final File image;

  const AdvocateEmailVerify(
      {Key? key,
      required this.otp,
      required this.email,
      required this.name,
      required this.phone,
      required this.password,
      required this.address,
      required this.type,
      required this.profession,
      required this.age,
      required this.coveredArea,
      required this.regions,
      required this.country,
      required this.city,
      required this.probono,
      required this.fOfServices,
      required this.image})
      : super(key: key);

  @override
  State<AdvocateEmailVerify> createState() => _AdvocateEmailVerifyState();
}

class _AdvocateEmailVerifyState extends State<AdvocateEmailVerify> {
  Duration duration = Duration(seconds: 60);
  bool timerStart = false;
  var otpGenerator = RandomStringGenerator(
    hasDigits: true,
    fixedLength: 4,
    hasAlpha: false,
    hasSymbols: false,
  );

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds - addSeconds;
      duration = Duration(seconds: seconds);
    });
    if (duration.inSeconds.remainder(60) == 0) {
      setState(() {
        duration = Duration(seconds: 59);
        timerStart = false;
      });
    }
  }

  void startTimer() {
    setState(() {
      timerStart = true;
    });
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      addTime();
    });
  }

  Widget build(BuildContext context) {
    String requiredNumber = '1234';
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xffFCD917),
              title: const Text(
                'Email Verification',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                CustomImage(
                  conheight: height * 0.25,
                  conwidth: width * 0.5,
                  // borderColor: Colors.grey,
                  // borderwidth: width*0.001,
                  // borderRadwidth: width*0.07,
                  Image: 'images/logo.jpg',
                ),
                Text(
                  'Enter the Verification Code we \n just sent you on your E-mail',
                  style: TextStyle(
                    fontSize: width * 0.05,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),

                //Text("  An 4 Digit code has been sent \n          to +971 834777995 ",style: TextStyle(color: Colors.white,fontSize: 20,),),

                Container(
                  margin: EdgeInsets.only(
                      right: width * 0.1,
                      left: width * 0.1,
                      top: height * 0.05),
                  child: PinCodeTextField(
                    length: 4,
                    textStyle: TextStyle(color: Colors.black),
                    appContext: context,
                    onChanged: (value) {
                      print(value);
                    },
                    cursorColor: Colors.black,
                    hapticFeedbackTypes: HapticFeedbackTypes.medium,
                    hintCharacter: "x",
                    useHapticFeedback: true,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      selectedFillColor: Colors.black,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: height * 0.08,
                      fieldWidth: width * 0.12,
                      inactiveColor: const Color(0xffFCD917),
                      activeColor: Colors.yellow,
                      selectedColor: Colors.yellow,
                    ),
                    onCompleted: (value) {
                      if (value == widget.otp ||
                          value == context.read<OtpProvider>().OTP) {
                        context.read<OtpProvider>().setVerified(true);
                        registerUser();
                      } else if (value.length == 4 && value != widget.otp) {
                        Utils().toastMessage("Invalid Pin Try Again");
                      }
                    },
                  ), // end Padding()
                ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.2),
                  child: Row(
                    children: [
                      Text(
                        "Didn't recieve code?",
                        style: TextStyle(
                            fontSize: width * 0.04, wordSpacing: width * 0.002),
                      ),
                      TextButton(
                          onPressed: !timerStart
                              ? () async {
                                  startTimer();
                                  var emailJS = Uri.parse(
                                      "https://api.emailjs.com/api/v1.0/email/send");
                                  var header = {
                                    "Content-Type": "application/json",
                                  };
                                  String code = otpGenerator.generate();
                                  Provider.of<OtpProvider>(context,
                                          listen: false)
                                      .setOTP(code);
                                  var response = await http.post(emailJS,
                                      headers: header,
                                      body: json.encode({
                                        "service_id": "service_y0qy9wf",
                                        "template_id": "template_lk61b4l",
                                        "user_id": "DUuUd1QWscbZpx6yJ",
                                        "template_params": {
                                          "to_name": widget.name,
                                          "otp_code": code,
                                          "subject":
                                              "${widget.name} OTP For the Application ADVOLOCATE",
                                          "user_email": widget.email,
                                        }
                                      }));
                                  context.watch<OtpProvider>().setOTP(code);
                                }
                              : () {},
                          child: timerStart
                              ? Text(
                                  "$minutes:$seconds",
                                  style: TextStyle(
                                      color: const Color(0xffFCD917),
                                      fontSize: width * 0.04),
                                )
                              : Text(
                                  'Resend',
                                  style: TextStyle(
                                      color: const Color(0xffFCD917),
                                      fontSize: width * 0.04),
                                )),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                    height: height * 0.075,
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.white,
                        width: width * 0.008,
                        style: BorderStyle.solid,
                      ),
                    ),
                    // color: Colors.green,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPass(),));
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        backgroundColor: const Color(0xffFCD917),
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          // <-- Radius
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 1),
                      ),
                    )),
              ]),
            )));
  }

  Future<void> registerUser() async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://www.advolocate.info/api/register_advocate'));
    request.fields.addAll({
      'name': widget.name,
      'email': widget.email,
      'password': widget.password,
      'contact_number': widget.phone,
      'address': widget.address,
      'profession': widget.profession,
      'covered_area': widget.coveredArea,
      'region_id': widget.regions,
      'country_id': widget.country,
      'city_id': widget.city,
      'probono': widget.probono,
      'field_of_service': widget.fOfServices,
      'age': widget.age,
      'gender': 'Male'
    });
    request.files.add(
        await http.MultipartFile.fromPath('license', '${widget.image!.path}'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print();

      var ress = await response.stream.bytesToString();
      Map<String, dynamic> data = json.decode(ress);

      if (data['code'] == 0) {
        Utils().toastMessage(data['description'].toString());
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManualLoginScreen(),
            ));
      } else {
        Utils().toastMessage(data['description'].toString());
      }
      //
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
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
