import 'package:advolocate_app/loginscreens/manuallogin.dart';
import 'package:flutter/material.dart';
import '../custom_button.dart';
class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffFCD917),
          title: const Text('New Password'),
        ),
        body:Container(padding: EdgeInsets.fromLTRB(width*0.05, height*0.05, width*0.05, height*0.05),
            height: height,
            width: width,
            color: Colors.white,
            child: Column(
                children: [
                  CustomImage(
                    conheight: height*0.25,
                    conwidth: width*0.5,
                    // borderColor: Colors.grey,
                    // borderwidth: width*0.001,
                    // borderRadwidth: width*0.07,
                    Image: 'images/logo.jpg',
                  ),
                  SizedBox(
                    //padding: EdgeInsets.only(right: width*0.2),
                    // height: height*0.05,
                    width: width,
                    child:Text('Enter New Password',style: TextStyle(fontSize: width*0.04,color: Colors.black,),),
                  ),
                  SizedBox(height: height*0.02,),
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
                      // controller: passwordComtroller,
                      maxLines: 1,
                      obscureText:_isObscure,
                      style: const TextStyle(
                        //color: Colors.black
                      ),

                      decoration: InputDecoration(
                        //fillColor: Colors.white,
                        // hintText: '●●●●●●',
                        hintText: 'Enter Password',
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.lock,color: Colors.black),
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              _isObscure=!_isObscure;
                            });
                          },
                          icon: Icon(_isObscure?Icons.visibility:Icons.visibility_off),
                        ),
                        hintStyle: const TextStyle(color:
                        Colors.black87,
                          // Colors.grey,
                        ),
                        contentPadding: const EdgeInsets.only(left: 30),
                        border:myinputborder(),
                        enabledBorder: myinputborder(),
                        // OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.white,width: 3),
                        //     borderRadius: BorderRadius.circular(30),),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Password is required';
                        }
                        return null;
                      },
                      // onChanged: (value) {
                      //   // do something
                      // },
                    ),
                  ),
                  SizedBox(height: height*0.05,),
                  SizedBox(
                    //padding: EdgeInsets.only(right: width*0.2),
                    // height: height*0.05,
                    width: width,
                    child:Text('Confirm Password',style: TextStyle(fontSize: width*0.04,color: Colors.black,),),
                  ),
                  SizedBox(height: height*0.02,),
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
                      // controller: passwordComtroller,
                      maxLines: 1,
                      obscureText:_isObscure,
                      style: const TextStyle(
                        //color: Colors.black
                      ),

                      decoration: InputDecoration(
                        //fillColor: Colors.white,
                        // hintText: '●●●●●●',
                        hintText: 'Enter Password',
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.lock,color: Colors.black),
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              _isObscure=!_isObscure;
                            });
                          },
                          icon: Icon(_isObscure?Icons.visibility:Icons.visibility_off),
                        ),
                        hintStyle: const TextStyle(color:
                        Colors.black87,
                          // Colors.grey,
                        ),
                        contentPadding: const EdgeInsets.only(left: 30),
                        border:myinputborder(),
                        enabledBorder: myinputborder(),
                        // OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.white,width: 3),
                        //     borderRadius: BorderRadius.circular(30),),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Password is required';
                        }
                        return null;
                      },
                      // onChanged: (value) {
                      //   // do something
                      // },
                    ),
                  ),

                  SizedBox(height: height*0.08,),
                  Container(
                      height: height*0.075,
                      width: width*0.85,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Colors.white,
                          width: width*0.008,
                          style: BorderStyle.solid,

                        ),
                      ),
                      // color: Colors.green,
                      child:ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManualLoginScreen(),));
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black, backgroundColor: const Color(0xffFCD917),
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            // <-- Radius
                          ),

                        ),
                        child: const Text('Submit',style: TextStyle(
                          // fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 1
                        ),),
                      )),

                ]
            )
        )

    ),
    );
  }
}

OutlineInputBorder myinputborder(){ //return type is OutlineInputBorder
  return const OutlineInputBorder( //Outline border type for TextFeild
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(
      color:Color(0xffFCD917),
      width: 1,
    ),
  );
}