// import 'package:advolocate_app/custom_button.dart';
// import 'package:advolocate_app/loginscreens/signup.dart';
// import 'package:advolocate_app/utils/utils.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class PasswordForgotScreen extends StatefulWidget {
//   const PasswordForgotScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PasswordForgotScreen> createState() => _PasswordForgotScreenState();
// }
//
// class _PasswordForgotScreenState extends State<PasswordForgotScreen> {
//   static GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   final emailComtroller = TextEditingController();
//
//   // bool isEmailVerfied = false;
//   //
//   //
//   //
//   //
//
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   // Future<void> inputData() async {
//   //   User? user = await FirebaseAuth.instance.currentUser;
//   //
//   //   if (user!= null && !user.emailVerified) {
//   //     print(user.emailVerified);
//   //   }
//   //   else{
//   //     print('input else');
//   //   }
//   //     // rest of the code|  do stuff
//   //
//   //
//   //   // here you write the codes to input the data into firestore
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xffFCD917),
//           title: const Text('Forgot Password'),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.fromLTRB(
//                 width * 0.05, height * 0.05, width * 0.05, height * 0.05),
//             height: height,
//             width: width,
//             color: Colors.white,
//             child: Form(
//               key: formkey,
//               child: Column(
//                 children: [
//                   CustomImage(
//                     conheight: height * 0.25,
//                     conwidth: width * 0.5,
//                     // borderColor: Colors.grey,
//                     // borderwidth: width*0.001,
//                     // borderRadwidth: width*0.07,
//                     Image: 'images/logo.jpg',
//                   ),
//                   Container(
//                       child: Text(
//                     '      Enter the Email Address \n Associated With Your Account',
//                     style: TextStyle(
//                         fontSize: width * 0.04,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold),
//                   )),
//                   SizedBox(
//                     height: height * 0.04,
//                   ),
//                   SizedBox(
//                     //padding: EdgeInsets.only(right: width*0.2),
//                     // height: height*0.05,
//                     width: width,
//                     child: Text(
//                       'Enter Email Address',
//                       style: TextStyle(
//                         fontSize: width * 0.04,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: height * 0.02,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.4),
//                           spreadRadius: 2,
//                           blurRadius: 8,
//                         ),
//                       ],
//                     ),
//                     child: TextFormField(
//                       controller: emailComtroller,
//                       maxLines: 1,
//                       style: const TextStyle(
//                           //color: Colors.black
//                           ),
//                       decoration: InputDecoration(
//                         //fillColor: Colors.white,
//                         hintText: 'Email',
//                         fillColor: Colors.white,
//                         filled: true,
//                         prefixIcon:
//                             const Icon(Icons.email_outlined, color: Colors.black),
//                         hintStyle: const TextStyle(color: Colors.black87),
//                         contentPadding: const EdgeInsets.only(left: 30),
//                         border: myinputborder(),
//                         enabledBorder: myinputborder(),
//                         // OutlineInputBorder(
//                         //   borderSide: BorderSide(color: Colors.white,width: 3),
//                         //     borderRadius: BorderRadius.circular(30),),
//                       ),
//
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Email is required';
//                         }
//                         return null;
//                       },
//                       // onChanged: (val) {
//                       //
//                       // },
//                     ),
//                   ),
//                   SizedBox(
//                     height: height * 0.04,
//                   ),
//                   Container(
//                       height: height * 0.075,
//                       width: width * 0.85,
//                       decoration: BoxDecoration(
//                         borderRadius:
//                             BorderRadius.all(Radius.circular(width * 0.2)),
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 3,
//                           style: BorderStyle.solid,
//                         ),
//                       ),
//                       // color: Colors.green,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           //  FirebaseAuth.instance.sendPasswordResetEmail(email: emailComtroller.text).then((value) => Navigator.of(context).pop());
//                           //
//                           //   if(auth.currentUser==null){
//                           //     Utils().toastMessage('Email not verified');
//                           //
//                           //     //Utils().toastMessage(value.user!.email.toString());
//                           //   }
//                             //else
//
//                            // passwordReset();
//                             FirebaseAuth.instance.sendPasswordResetEmail(email: emailComtroller.text).then((value){
//                             Utils().toastMessage('We have sent you email password please check email');
//                             Navigator.of(context).pop();
//
//                           }).onError((error,stackTrace){
//                             Utils().toastMessage(error.toString());
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           shadowColor: Colors.black, backgroundColor: const Color(0xffFCD917),
//                           elevation: width * 0.03,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(width * 0.1),
//                             // <-- Radius
//                           ),
//                         ),
//                         child: Text(
//                           'Send',
//                           style: TextStyle(
//                             // fontWeight: FontWeight.bold,
//                             fontSize: width * 0.05,
//                             letterSpacing: width * 0.002,
//                           ),
//                         ),
//                       )),
//                   SizedBox(
//                     height: height * 0.1,
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: width * 0.2),
//                     child: Row(
//                       children: [
//                         Text(
//                           "Don't have account?",
//                           style: TextStyle(
//                               fontSize: width * 0.04,
//                               wordSpacing: width * 0.002),
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const SignUpScreen(),
//                                   ));
//                             },
//                             child: Text(
//                               'SignUp',
//                               style: TextStyle(
//                                   color: const Color(0xffFCD917),
//                                   fontSize: width * 0.04),
//                             )),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// OutlineInputBorder myinputborder() {
//   //return type is OutlineInputBorder
//   return const OutlineInputBorder(
//     //Outline border type for TextFeild
//     borderRadius: BorderRadius.all(Radius.circular(20)),
//     borderSide: BorderSide(
//       color: Color(0xffFCD917),
//       width: 1,
//     ),
//   );
// }
import 'package:advolocate_app/custom_button.dart';
import 'package:advolocate_app/loginscreens/manuallogin.dart';
import 'package:advolocate_app/loginscreens/selection.dart';
import 'package:advolocate_app/loginscreens/signup.dart';
import 'package:advolocate_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PasswordForgotScreen extends StatefulWidget {
  const PasswordForgotScreen({Key? key}) : super(key: key);

  @override
  State<PasswordForgotScreen> createState() => _PasswordForgotScreenState();
}

class _PasswordForgotScreenState extends State<PasswordForgotScreen> {
  static GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final emailComtroller = TextEditingController();

  // bool isEmailVerfied = false;
  //
  //
  //
  //

  // final FirebaseAuth auth = FirebaseAuth.instance;

  // Future<void> inputData() async {
  //   User? user = await FirebaseAuth.instance.currentUser;
  //
  //   if (user!= null && !user.emailVerified) {
  //     print(user.emailVerified);
  //   }
  //   else{
  //     print('input else');
  //   }
  //     // rest of the code|  do stuff
  //
  //
  //   // here you write the codes to input the data into firestore
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffFCD917),
          title: const Text('Forgot Password'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.05, width * 0.05, height * 0.05),
            height: height,
            width: width,
            color: Colors.white,
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  CustomImage(
                    conheight: height * 0.25,
                    conwidth: width * 0.5,
                    // borderColor: Colors.grey,
                    // borderwidth: width*0.001,
                    // borderRadwidth: width*0.07,
                    Image: 'images/logo.jpg',
                  ),
                  Container(
                      child: Text(
                        '      Enter the Email Address \n Associated With Your Account',
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  SizedBox(
                    //padding: EdgeInsets.only(right: width*0.2),
                    // height: height*0.05,
                    width: width,
                    child: Text(
                      'Enter Email Address',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
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
                          if (formkey.currentState!.validate()) {
                            forgotPass();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ManualLoginScreen(),
                                ));

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
                          'Send',
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: width * 0.05,
                            letterSpacing: width * 0.002,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.2),
                    child: Row(
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
      ),
    );
  }

  void forgotPass() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = json.encode({
      "email": emailComtroller.text.toString(),
    });
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/forgotPassword'),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      if (data['code'] == 0) {
        Utils().toastMessage(data['description']);
      } else {
        Utils().toastMessage(data['description']);
      }
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
