import 'package:advolocate_app/main.dart';
import 'package:advolocate_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final firestore = FirebaseFirestore.instance
      .collection('List of registered username')
      .snapshots();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFCD917),
        actions: [
          IconButton(
              onPressed: () {
                GoogleSignIn().disconnect();
                FirebaseAuth.instance.signOut();
                auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyApp(),
                      ));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: const Icon(Icons.power_settings_new))
        ],
      ),
      body: Center(
          child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder:
                  (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text('Error');
                }
                return Text(snapshot.data!.docs[0]['name'].toString());
              }),
        ],
      )),
    );
  }
}
