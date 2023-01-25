import 'package:advolocate_app/loginscreens/createadvocate.dart';
import 'package:advolocate_app/loginscreens/createuser.dart';
import 'package:advolocate_app/loginscreens/verification.dart';
import 'package:advolocate_app/main.dart';
import 'package:advolocate_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Model/registerCustomer_api.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //final usernameController =TextEditingController();
  bool loading = false;
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final emailComtroller = TextEditingController();
  final passwordComtroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailComtroller.dispose();
    passwordComtroller.dispose();
  }

  void signup() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
      email: emailComtroller.text.toString(),
      password: passwordComtroller.text.toString(),
    )
        .then((value) {
      setState(() {
        loading = false;
      });
      // String id= DateTime.now().millisecondsSinceEpoch.toString();
      // firestore.doc(_auth.currentUser!.uid).set({
      //   'id':id,
      //   'name': usernameController.text.toString(),
      //   'category':_chosenValue.toString(),
      // });
      //  databaseRef.child(usernameController.text.toString()).set({
      //   'Result':'Name: '+usernameController.text.toString()+"\nCategory is: "+_chosenValue.toString(),
      // });
      // Navigator.push(context, MaterialPageRoute(builder: (context) => home(
      //   //  usertype: _chosenValue,
      // ),));

      //
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          // color: Color(0xffff5722),
          child: Column(children: [
            Image.asset(
              'images/logosplash.png',
              height: 250,
            ),
            Form(
              key: _formKey,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 35,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: width * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
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
                                    // OutlineInputBorder(
                                    //   borderSide: BorderSide(color: Colors.white,width: 3),
                                    //     borderRadius: BorderRadius.circular(30),),
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
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateAdvocateAccount(),
                                          ));
                                    },
                                    child: Text(
                                      'Register as Advocate',
                                      style: TextStyle(
                                        fontSize: width * 0.04,
                                        color: const Color(0xffFCD917),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(width * 0.2)),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateUserAccount(
                                                email: emailComtroller.text,
                                                password:
                                                    passwordComtroller.text,
                                              )));
                                }

                                // if (_formKey.currentState!.validate()){
                                //   signup();
                                // }
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
                              child: loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'SIGNUP',
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: width * 0.05,
                                        letterSpacing: width * 0.002,
                                        // color: Colors.black,
                                      ),
                                    ),
                            )),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: width * 0.2),
                          child: Row(
                            children: [
                              Text(
                                "Already have an account?",
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
                                                const MyApp()));
                                  },
                                  child: Text(
                                    'Login',
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
          ]),
        ),
      ),
    );
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
