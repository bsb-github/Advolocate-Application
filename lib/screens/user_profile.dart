import 'dart:convert';
import 'dart:io';

import 'package:advolocate_app/Model/profile_data_model.dart';
import 'package:advolocate_app/Providers/ConfigProviders.dart';
import 'package:advolocate_app/Providers/ImageUrlProvider.dart';
import 'package:advolocate_app/utils/UpdateProfileData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/AdvocatesData.dart';
import '../util/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int _selectedIndex = 1;
  File? image;
  bool loading = true;
  ProfileDataModel profileDataModel = ProfileDataModel();

  var generator = RandomStringGenerator(
    hasAlpha: true,
    alphaCase: AlphaCase.UPPERCASE_ONLY,
    hasDigits: false,
    hasSymbols: true,
    minLength: 10,
    maxLength: 25,
    mustHaveAtLeastOneOfEach: true,
  );
  var data = ProfileDataList.users[0];

  String imgeUrl =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  //File img = File(.result!.imgUrl as String);
  updateImage() async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      print(storageRef.fullPath);
      final imageRef = storageRef.child('images/${generator.generate()}');
      await imageRef.putFile(image!).then((p0) {
        const SnackBar snackBar = SnackBar(content: Text('Image Uploaded'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).onError((error, stackTrace) {
        const SnackBar snackBar =
            SnackBar(content: Text('Error Uploading Image'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
      imgeUrl = await imageRef.getDownloadURL();
      Provider.of<ImageUrlProvider>(context, listen: false)
          .setImageURl(imgeUrl);
    } on FirebaseException catch (e) {
      const SnackBar snackBar = SnackBar(content: Text('Error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> UploadImage(String imageURl) async {
    print("data:image/jpeg;base64," + imgeUrl);
    var getCustomerInfoToken = context.read<ConfigProvider>().token;
    print(getCustomerInfoToken);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getCustomerInfoToken}',
    };
    print(
        'Bearer ${Provider.of<ConfigProvider>(context, listen: false).token}');
    var body = jsonEncode({
      "user_id": profileDataModel.result!.userId as int,
      "name": profileDataModel.result!.name as String,
      "contact_number": profileDataModel.result!.contactNumber as String,
      "email": profileDataModel.result!.email as String,
      "address": profileDataModel.result!.address as String,
      "selectedCountry": 1,
      "img_url": "data:image/jpeg;base64," + imgeUrl,
    });
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/updateCustomerInfo'),
        headers: headers,
        body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('helllllllllllllllllllllllll')));
    }
    // if (response.statusCode == 200) {
    //   var data = jsonDecode(response.body.toString());
    //   print(data);
    //   print(data['description']);
    //   if (data['code'] == 0) {
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => ManualLoginScreen()));
    //   } else {
    //     Utils().toastMessage(data['description'].toString());
    //   }
    // } else {
    //   print(response.reasonPhrase);
    // }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      await updateImage();
      print(imgeUrl);
      // Upload to API
      UploadImage(imgeUrl);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('token');
    getData(context);
    setState(() {});

    if (profileDataModel.result == null) {
      if (data.userType <= 5) {
        loadingFun();
      } else {}
    } else {
      loadingFun();
    }
  }

  loadingFun() {
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return SafeArea(
      child: loading == false
          ? WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => UpdateBottomSheet(
                              name: profileDataModel.result?.name.toString() ??
                                  data.name,
                              contact_number:
                                  profileDataModel.result?.contactNumber ??
                                      data.contact_number,
                              address: profileDataModel.result?.address ??
                                  data.address,
                              city: profileDataModel
                                      .result?.selectedCity!.label ??
                                  data.city_name,
                              email:
                                  profileDataModel.result?.email ?? data.email,
                            ));
                  },
                  backgroundColor: Colors.amber[400],
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
                appBar: AppBar(
                  // leading: IconButton(
                  //   icon: Icon(Icons.arrow_back_ios),
                  //   color: Colors.black,
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                  automaticallyImplyLeading: false,
                  // leading: IconButton(
                  //   icon: const Icon(Icons.arrow_back_ios),
                  //   onPressed: () {
                  //     // Navigator.popAndPushNamed(context, '/home');
                  //     Navigator.pop(context);
                  //   },
                  // ),
                  // iconTheme: const IconThemeData(color: Colors.black),
                  centerTitle: true,
                  title: const Text(
                    'Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 0,
                ),
                body: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    child: Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Positioned(
                      top: height * 0.10,
                      bottom: height * 0.001,
                      child: Container(
                        height: height,
                        width: width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0),
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.1),

                          ///Lawyer name and address

                          child: Column(
                            children: [
                              loading == false
                                  ? Column(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                                child: Text(
                                              profileDataModel.result?.name ??
                                                  data.name,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                child: Text(
                                              profileDataModel
                                                      .result?.address ??
                                                  data.address,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )),
                                          ],
                                        ),

                                        ///general info
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.01,
                                              right: width * 0.6),
                                          child: Container(
                                              child: const Text(
                                            'General info',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                        RowInfo(
                                            width,
                                            height,
                                            Icons.person,
                                            'Name',
                                            profileDataModel.result?.name ??
                                                data.name,
                                            context),
                                        RowInfo(
                                            width,
                                            height,
                                            Icons.location_on,
                                            'Address',
                                            profileDataModel.result?.address ??
                                                data.address,
                                            context),
                                        RowInfo(
                                            width,
                                            height,
                                            Icons.travel_explore,
                                            'Country',
                                            profileDataModel.result
                                                    ?.selectedCountry?.label ??
                                                data.address,
                                            context),

                                        // contact me
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.01,
                                              right: width * 0.6),
                                          child: Container(
                                              child: const Text(
                                            'Contact me',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),

                                        RowInfo(
                                            width,
                                            height,
                                            Icons.phone,
                                            'Phone Number',
                                            profileDataModel
                                                    .result?.contactNumber ??
                                                data.contact_number,
                                            context),
                                        RowInfo(
                                            width,
                                            height,
                                            Icons.mail,
                                            'Mail',
                                            profileDataModel.result?.email ??
                                                data.email,
                                            context),
                                      ],
                                    )
                                  : CircularProgressIndicator(
                                      color: Colors.yellow,
                                    )
                            ],
                          ),
                        ),

                        ///Lawyer name and address
                      )),
                  Positioned(
                    top: height * 0.01,
                    // right: width*0.35,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: CircleAvatar(
                              backgroundColor: Color(0xffFCD917),
                              radius: 60,
                              child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage:
                                      profileDataModel.result?.imgUrl == null
                                          ? NetworkImage(context
                                              .watch<ImageUrlProvider>()
                                              .imageUrl)
                                          : NetworkImage(
                                              "https://www.advolocate.info" +
                                                  profileDataModel
                                                      .result!.imgUrl
                                                      .toString()))),
                        ),
                        Container(
                            height: 37,
                            width: 37,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Icon(
                              Icons.edit,
                              color: Theme.of(context).primaryColor,
                            ))),
                      ],
                    ),
                  )
                ]),
              ),
            )
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              ),
            ),
    );
  }

  Future<void> getData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');
    var url = Uri.parse('http://www.advolocate.info/api/getCustomerInfo');

    print('get data token');
    print(token);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}',
    };
    var response = await http.post(url,
        body: jsonEncode({"user_id": userId}), headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      profileDataModel = ProfileDataModel.fromJson(jsonDecode(response.body));
    }
    setState(() {});
  }

  void navigateBottomBar(int index) {
    _selectedIndex = index;
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, '/home');
      } else if (index == 1) {
        Navigator.pushNamed(context, '/profile');
      } else if (index == 3) {
        Navigator.pushNamed(context, '/cso_laws');
      } else if (index == 2) {
        Navigator.pushNamed(context, '/privacy_policy');
      }
    });
  }
}
