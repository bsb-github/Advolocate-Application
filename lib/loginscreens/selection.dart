import 'package:advolocate_app/loginscreens/createadvocate.dart';
import 'package:advolocate_app/loginscreens/createuser.dart';
import 'package:flutter/material.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'images/logosplash.png',
              height: 250,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.05, width * 0.05, height * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                    height: height * 0.07,
                    child: Text(
                      'Registered As:',
                      style: TextStyle(
                          fontSize: width * 0.08,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: height * 0.1,
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CreateAdvocateAccount(),
                            ));
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
                        'Advocate',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: width * 0.05,
                          letterSpacing: width * 0.002,
                          //color: Colors.black,
                        ),
                      ),
                    )),
                SizedBox(
                  height: height * 0.05,
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateUserAccount(
                                email: "",
                                password: "",
                              ),
                            ));
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
                        'User',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: width * 0.05,
                          letterSpacing: width * 0.002,
                          //color: Colors.black,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ]),
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
