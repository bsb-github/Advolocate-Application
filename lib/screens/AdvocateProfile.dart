import 'dart:convert';
import 'dart:io';

import 'package:advolocate_app/Model/profile_data_model.dart';
import 'package:advolocate_app/Providers/ConfigProviders.dart';
import 'package:advolocate_app/Providers/ImageUrlProvider.dart';
import 'package:advolocate_app/Providers/LawyerDataProvider.dart';
import 'package:advolocate_app/loginscreens/UpdateAdvocateBottomSheet.dart';
import 'package:advolocate_app/utils/UpdateProfileData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../util/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AdvocateProfile extends StatefulWidget {
  const AdvocateProfile({
    super.key,
  });

  @override
  State<AdvocateProfile> createState() => _AdvocateProfileState();
}

class _AdvocateProfileState extends State<AdvocateProfile> {
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
      "user_id": context.read<LawyerDataProvider>().advData.Uid,
      "name": context.read<LawyerDataProvider>().advData.name,
      "contact_number": context.read<LawyerDataProvider>().advData.country,
      "email": context.read<LawyerDataProvider>().advData.email,
      "address": context.read<LawyerDataProvider>().advData.address,
      "selectedCountry": context.read<LawyerDataProvider>().advData.country,
      "img_url": "data:image/jpeg;base64," + imgeUrl,
    });
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/updateCustomerInfo'),
        headers: headers,
        body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Updated')));
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
    var data = context.read<LawyerDataProvider>().data;
    var list =
        List.from(context.read<LawyerDataProvider>().data.services.split(","));
    return SafeArea(
      child: loading == false
          ? WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => UpdateAdvocateBottomSheet(
                            email: data.email,
                            social_id: "",
                            name: data.name,
                            type: data.userType));
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
                  actions: [
                    IconButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyApp(),
                              ));
                        },
                        icon: Icon(
                          Icons.login,
                          color: Colors.black,
                          size: width * 0.07,
                        ))
                  ],
                  automaticallyImplyLeading: false,
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
                      top: height * 0.08,
                      bottom: height * 0.001,
                      child: Container(
                        height: height,
                        width: width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.1),

                          ///Lawyer name and address

                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                loading == false
                                    ? Consumer(
                                        builder: (context, value, child) =>
                                            Column(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                    child: Text(
                                                  context
                                                      .read<
                                                          LawyerDataProvider>()
                                                      .data
                                                      .name,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                    child: Text(
                                                  context
                                                      .read<
                                                          LawyerDataProvider>()
                                                      .data
                                                      .covered_area,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                )),
                                              ],
                                            ),

                                            ///general info
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: width * 0.6),
                                                  child: Container(
                                                      child: const Text(
                                                    'General info',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                                RowInfo(
                                                    width,
                                                    height,
                                                    Icons.person,
                                                    'Name',
                                                    context
                                                        .read<
                                                            LawyerDataProvider>()
                                                        .data
                                                        .name,
                                                    context),
                                                RowInfo(
                                                    width,
                                                    height,
                                                    Icons.location_on,
                                                    'Address',
                                                    context
                                                        .read<
                                                            LawyerDataProvider>()
                                                        .data
                                                        .address,
                                                    context),
                                                SizedBox(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: height * 0.01,
                                                        left: width * 0.1),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            decoration: BoxDecoration(
                                                                color: const Color(
                                                                    0xffFCD917),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7)),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(7),
                                                            child: Icon(
                                                              Icons.work,
                                                              size: 32,
                                                            )),
                                                        SizedBox(
                                                          width: width * 0.03,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Services",
                                                              maxLines: 5,
                                                              softWrap: false,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                            Container(
                                                                constraints: BoxConstraints(
                                                                    maxHeight:
                                                                        300,
                                                                    maxWidth:
                                                                        width *
                                                                            0.5,
                                                                    minHeight:
                                                                        20),

                                                                // :
                                                                //       list.length *
                                                                //           20,
                                                                //   width:
                                                                //       width * 0.7,
                                                                child: ListView
                                                                    .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: list
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Text(
                                                                      index == 0
                                                                          ? ' ' +
                                                                              list[index]
                                                                          : list[index],
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                    );
                                                                  },
                                                                ))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // RowInfo(
                                                //     width,
                                                //     height,
                                                //     Icons.travel_explore,
                                                //     'Country',
                                                //     context
                                                //         .read<
                                                //             LawyerDataProvider>()
                                                //         .data
                                                //         .services,
                                                //     context),
                                                RowInfo(
                                                    width,
                                                    height,
                                                    Icons.work,
                                                    'Profession',
                                                    context
                                                        .read<
                                                            LawyerDataProvider>()
                                                        .advData
                                                        .profession,
                                                    context),
                                                RowInfo(
                                                    width,
                                                    height,
                                                    Icons.place,
                                                    'Covered Area',
                                                    context
                                                        .read<
                                                            LawyerDataProvider>()
                                                        .advData
                                                        .coveredArea,
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),

                                                RowInfo(
                                                    width,
                                                    height,
                                                    Icons.phone,
                                                    'Phone Number',
                                                    context
                                                        .read<
                                                            LawyerDataProvider>()
                                                        .data
                                                        .contact_number,
                                                    context),
                                                RowInfo(
                                                    width,
                                                    height,
                                                    Icons.mail,
                                                    'Mail',
                                                    context
                                                        .read<
                                                            LawyerDataProvider>()
                                                        .data
                                                        .email,
                                                    context),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : CircularProgressIndicator(
                                        color: Colors.yellow,
                                      )
                              ],
                            ),
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
      // ignore: use_build_context_synchronously
      Provider.of<LawyerDataProvider>(context, listen: false)
          .setData(ProfileData.fromJson(jsonDecode(response.body)["result"]));
      setState(() {});
      //profileDataModel = ProfileDataModel.fromJson(jsonDecode(response.body));
    }
  }
}
