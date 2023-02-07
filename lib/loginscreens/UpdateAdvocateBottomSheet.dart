import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:advolocate_app/Model/AdvocatesData.dart';
import 'package:advolocate_app/Model/meta_data_model.dart';
import 'package:advolocate_app/Model/profile_data_model.dart';
import 'package:advolocate_app/Providers/LawyerDataProvider.dart';
import 'package:advolocate_app/home.dart';
import 'package:advolocate_app/loginscreens/manuallogin.dart';
import 'package:advolocate_app/loginscreens/verification.dart';
import 'package:advolocate_app/main.dart';
import 'package:advolocate_app/screens/AdvocateHomePage.dart';
import 'package:advolocate_app/utils/utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:http/http.dart' as http;

import '../util/homepage/multiselect_dropdown.dart';

class UpdateAdvocateBottomSheet extends StatefulWidget {
  final String email;
  final String social_id;
  final String name;
  final int type;
  const UpdateAdvocateBottomSheet(
      {super.key,
      required this.email,
      required this.social_id,
      required this.name,
      required this.type});

  @override
  State<UpdateAdvocateBottomSheet> createState() =>
      _UpdateAdvocateBottomSheetState();
}

class _UpdateAdvocateBottomSheetState extends State<UpdateAdvocateBottomSheet> {
  String? regionsid;
  String? countriesId;
  String citiesId = '';
  String? probonoId;
  String? servicesId;

  //licence upload

  File? image;
  bool loading = true;
  final _pickerImagePicker = ImagePicker();

  Future getImage() async {
    final pickerFile =
        await _pickerImagePicker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      image = File(pickerFile.path);

      setState(() {});
    } else {
      debugPrint('No Image Selected');
    }
  }

  /////

  List services = [];
  List<MultiSelectDialogItem<int>> multiItem = [];
  final valuestopopulate = {
    15: "CIVIL RIGHTS LAW",
    16: "CRIMINAL LAW",
    17: "ENVIRONMENTAL LAW",
    18: "FAMILY LAW",
    19: "HEALTH LAW",
    20: "IMMIGRATION LAW",
    21: "INTELLECTUAL PROPERTY LAW",
    22: "EMPLOYMENT/LABOR LAW",
    23: "PERSONAL INJURY LAW",
    24: "TAX LAW",
    25: "COMMUNICATIONS LAW",
    26: "CONSTITUTIONAL LAW",
    27: "CONSUMER LAW",
    28: "CYBER LAW",
    29: "BANKING AND FINANCE LAW",
    30: "CORPORATE LAW",
    31: "COMMERCIAL LAW",
    32: "PROPERTY LAW",
    33: "PUBLIC INTEREST LITIGATION",
    34: "PRIVACY LAW",
    35: "SOCIAL SERVICES",
    36: "CHILD PROTECTION",
    37: "MISCELLANEOUS",
    38: "HUMAN RIGHTS VIOLATION",
    39: "ALTERNATIVE DISPUTE RESOLUTION (ADR)",
    40: "MEDIA LAW",
    42: "CONTRACT LAW",
  };
  void getAdvocatesData() async {
    var response = await http
        .post(Uri.parse("http://www.advolocate.info/api/getAdvocatesData"));
    print(response.body);
    var data = jsonDecode(response.body);
    var advos = List.from(data["result"]);

    for (var i = 0; i < advos.length; i++) {
      AdvocatesList.data.add(AdvocatesData.fromJson(advos[i]));
    }
    print(AdvocatesList.data[34].email);
  }

  Set<int> sel = {};
  void populateMultiselect() {
    for (int v in valuestopopulate.keys) {
      multiItem.add(MultiSelectDialogItem(v, valuestopopulate[v]!));
    }
  }

  void _showMultiSelect(BuildContext context) async {
    // multiItem = [];
    populateMultiselect();
    final items = multiItem;
    // final items = <MultiSelectDialogItem<int>>[
    //   MultiSelectDialogItem(1, 'India'),
    //   MultiSelectDialogItem(2, 'USA'),
    //   MultiSelectDialogItem(3, 'Canada'),
    // ];

    // print('services as list');
    // print(services);
    Set<int>? selected = Set<int>();

    var l = Provider.of<LawyerDataProvider>(context, listen: false)
        .advData
        .services
        .split(",");
    var a = List.from(valuestopopulate.keys);
    var b = List.from(valuestopopulate.values);

    // for (int i = 0; i < l.length; i++) {
    //   String val = l[i].toLowerCase();
    //   for (int j = 0; j < b.length; j++) {
    //     if (val == b[j].toString().toLowerCase()) {
    //       setState(() {
    //         sel.add(a[j]);
    //       });
    //       continue;
    //     }
    //   }
    // }
    var li = <int>[];
    for (var element in l) {
      int count = 0;
      for (var el in b) {
        if (element.toUpperCase().trim() == el) {
          li.add(a[count]);
        }
        count++;
      }
    }
    sel.addAll(li);
    setState(() {});
    Set<int>? selectedValues = sel;
    selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: sel,
        );
      },
    );

    // print('services as set');
    // print(sel);
    // debugPrint(selectedValues);
    if (selectedValues == null) {
      getvaluefromkey(sel);
    } else {
      getvaluefromkey(selectedValues);
    }
  }

  var otpGenerator = RandomStringGenerator(
    hasDigits: true,
    fixedLength: 4,
    hasAlpha: false,
    hasSymbols: false,
  );

  void getvaluefromkey(Set<int> selection) {
    sel = selection;
    for (int x in selection.toList()) {
      services = selection.toList();

      // print(valuestopopulate[x]);
    }
  }

  String? City = 'City';

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _professionController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _coveredAreaController = TextEditingController();

  List<dynamic> regions = [];
  List<dynamic> countries = [];
  List<dynamic> cities = [
    {"label": "City"}
  ];
  List<dynamic> probono = [];

  List<dynamic> ct = [];
  // List<dynamic> services = [];
  Map<String, dynamic>? data;
  int lenght = 0;

  @override
  void initState() {
    var data = Provider.of<LawyerDataProvider>(context, listen: false).advData;
    super.initState();
    setState(() {
      _emailController.text = widget.email;
      _addressController.text = data.address;
      _professionController.text = data.profession;
      _coveredAreaController.text = data.coveredArea;
      _phoneNumberController.text = data.contact;

      _fullNameController.text = widget.name;
    });
    getData();
  }

  MetaDataModel metaDataModel = MetaDataModel();

  //final usernameController =TextEditingController();
  // bool loading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: loading == false
            ?
            // color: Color(0xffff5722),
            Column(children: [
                Form(
                  key: _formKey,
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Update Account',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),

                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: TextFormField(
                              controller: _fullNameController,
                              maxLines: 1,
                              style: const TextStyle(
                                  //color: Colors.black
                                  ),
                              decoration: InputDecoration(
                                //fillColor: Colors.white,
                                hintText: 'Full Name',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: const Icon(Icons.person,
                                    color: Colors.black),
                                hintStyle:
                                    const TextStyle(color: Colors.black87),
                                contentPadding: const EdgeInsets.only(left: 30),
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value == ' ') {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: TextFormField(
                              controller: _emailController,
                              maxLines: 1,
                              enabled: false,
                              style: const TextStyle(
                                  //color: Colors.black
                                  ),
                              decoration: InputDecoration(
                                //fillColor: Colors.white,
                                hintText: 'Email Address',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: const Icon(Icons.email_outlined,
                                    color: Colors.black),
                                hintStyle:
                                    const TextStyle(color: Colors.black87),
                                contentPadding: const EdgeInsets.only(left: 30),
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value == ' ') {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(
                            height: height * 0.04,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: TextFormField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              style: const TextStyle(
                                  //color: Colors.black
                                  ),
                              decoration: InputDecoration(
                                //fillColor: Colors.white,
                                hintText: 'Phone Number',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: const Icon(Icons.phone,
                                    color: Colors.black),
                                hintStyle:
                                    const TextStyle(color: Colors.black87),
                                contentPadding: const EdgeInsets.only(left: 30),
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value == ' ') {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: TextFormField(
                              controller: _addressController,
                              style: const TextStyle(
                                  //color: Colors.black
                                  ),
                              decoration: InputDecoration(
                                //fillColor: Colors.white,
                                hintText: 'Address',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black),
                                hintStyle:
                                    const TextStyle(color: Colors.black87),
                                contentPadding: const EdgeInsets.only(left: 30),
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                                // OutlineInputBorder(
                                //   borderSide: BorderSide(color: Colors.white,width: 3),
                                //     borderRadius: BorderRadius.circular(30),),
                              ),

                              validator: (value) {
                                if (value!.isEmpty || value == ' ') {
                                  return 'Required';
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
                            margin: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: TextFormField(
                              controller: _professionController,
                              //maxLines: 1,
                              style: const TextStyle(
                                  //color: Colors.black
                                  ),
                              decoration: InputDecoration(
                                //fillColor: Colors.white,
                                hintText: 'Profession',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: const Icon(
                                    Icons.business_center_outlined,
                                    color: Colors.black),
                                hintStyle:
                                    const TextStyle(color: Colors.black87),
                                contentPadding: const EdgeInsets.only(left: 30),
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                                // OutlineInputBorder(
                                //   borderSide: BorderSide(color: Colors.white,width: 3),
                                //     borderRadius: BorderRadius.circular(30),),
                              ),

                              validator: (value) {
                                if (value!.isEmpty || value == ' ') {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: TextFormField(
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(),
                              decoration: InputDecoration(
                                //fillColor: Colors.white,
                                hintText: 'Age',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: const Icon(Icons.person_outline,
                                    color: Colors.black),
                                hintStyle:
                                    const TextStyle(color: Colors.black87),
                                contentPadding: const EdgeInsets.only(left: 30),
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value == ' ') {
                                  return 'Required';
                                }

                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: TextFormField(
                              controller: _coveredAreaController,
                              //maxLines: 1,
                              style: const TextStyle(
                                  //color: Colors.black
                                  ),
                              decoration: InputDecoration(
                                //fillColor: Colors.white,
                                hintText: 'Covered Area',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black),
                                hintStyle:
                                    const TextStyle(color: Colors.black87),
                                contentPadding: const EdgeInsets.only(left: 30),
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                              ),

                              validator: (value) {
                                if (value!.isEmpty || value == ' ') {
                                  return 'Required';
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
                          FormHelper.dropDownWidget(
                            context,
                            '    Region',
                            regionsid,
                            regions,
                            (onChangedval) {
                              regionsid = onChangedval;
                            },
                            (onValidate) {
                              if (onValidate == null) {
                                return '   Required';
                              }
                              return null;
                            },
                            optionValue: 'value',
                            optionLabel: 'label',
                            textColor: Colors.black,
                            borderColor: const Color(0xffFCD917),
                            borderWidth: 1,
                            hintFontSize: width * 0.045,
                            hintColor: Colors.black,
                            borderFocusColor: const Color(0xffFCD917),
                            validationColor: Colors.red,
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),

                          FormHelper.dropDownWidget(
                            context,
                            '    Country',
                            countriesId,
                            countries,
                            (onChangedval) {
                              countriesId = onChangedval;

                              getCities(data!, lenght);
                            },
                            (onValidate) {
                              if (onValidate == null) {
                                return '    Required';
                              }
                              return null;
                            },
                            optionValue: 'value',
                            optionLabel: 'label',
                            textColor: Colors.black,
                            borderColor: const Color(0xffFCD917),
                            borderWidth: 1,
                            hintFontSize: width * 0.045,
                            hintColor: Colors.black,
                            borderFocusColor: const Color(0xffFCD917),
                            validationColor: Colors.red,
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          // city
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: DropdownSearch<String>(
                                onChanged: (value) {
                                  var obj = cities.where(
                                      (element) => element["label"] == value);
                                  setState(() {
                                    citiesId = obj.first["value"].toString();
                                  });

                                  print(citiesId);
                                },
                                items: List.from(cities.map((e) => e["label"])),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    baseStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    dropdownSearchDecoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(200)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(200)),
                                    )),
                                selectedItem: cities.first["label"],
                                popupProps: const PopupProps.dialog(
                                    fit: FlexFit.loose,
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                            hintText: "Search"))),
                              )),

                          SizedBox(
                            height: height * 0.04,
                          ),
                          FormHelper.dropDownWidget(
                            context,
                            '    Select Probono',
                            probonoId,
                            probono,
                            (onChangedval) {
                              probonoId = onChangedval;
                            },
                            (onValidate) {
                              if (onValidate == null) {
                                return '   Required';
                              }
                              return null;
                            },
                            optionValue: 'value',
                            optionLabel: 'label',
                            textColor: Colors.black,
                            borderColor: const Color(0xffFCD917),
                            borderWidth: 1,
                            hintFontSize: width * 0.045,
                            hintColor: Colors.black,
                            borderFocusColor: const Color(0xffFCD917),
                            validationColor: Colors.red,
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          InkWell(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: width * 0.05, right: width * 0.05),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  //  color: Colors.pink,
                                  border: Border.all(
                                    color: Color(0xffFCD917),
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                    left: width * 0.075,
                                    top: height * 0.02,
                                    //right: width*0.065,
                                    bottom: height * 0.02),
                                child: Row(
                                  children: [
                                    Text(
                                      'Field Of Services',
                                      style: TextStyle(
                                          fontSize: width * 0.045,
                                          color: const Color.fromARGB(
                                              255, 90, 89, 89)),
                                    ),
                                    SizedBox(
                                      width: width * 0.4,
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: Color.fromARGB(255, 90, 89, 89),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => _showMultiSelect(context)),
                          SizedBox(
                            height: height * 0.04,
                          ),

                          GestureDetector(
                            onTap: () {
                              debugPrint('hello');
                              getImage();
                            },
                            child: Container(
                              height: height * 0.07,
                              width: width * 0.9,
                              margin: EdgeInsets.only(
                                  left: width * 0.05, right: width * 0.05),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(width * 0.2)),
                                border: Border.all(
                                  color: Color(0xffFCD917),
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: width * 0.06),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: height * 0.050,
                                          width: width * 0.40,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xffFCD917),
                                              width: 1,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: image == null
                                              ? Center(
                                                  child: Text('Choose File',
                                                      style: TextStyle()),
                                                )
                                              : Center(
                                                  child: Text(
                                                    '${image!.path}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              // color: Colors.green,
                              child: Consumer(
                                builder: (context, value, child) =>
                                    ElevatedButton(
                                  onPressed: () async {
                                    debugPrint('printing services');
                                    print(services.toString());

                                    {
                                      getAdvocatesData();
                                      var data = AdvocatesList.data.where(
                                          (element) =>
                                              element.email ==
                                              _emailController.text);
                                      registerUser(context);
                                      final prefs =
                                          await SharedPreferences.getInstance();

                                      final String? token =
                                          prefs.getString('token');
                                      final int? userId =
                                          prefs.getInt('userId');
                                      var dataAdvocate = AdvocatesList.data
                                          .where((element) =>
                                              element.Uid == userId)
                                          .first;
                                      var headers = {
                                        'Content-Type': 'application/json',
                                        'Accept': 'application/json',
                                        "Authorization": "Bearer $token"
                                      };
                                      var resp = await http.post(
                                          Uri.parse(
                                              "http://www.advolocate.info/api/getCustomerInfo"),
                                          headers: headers,
                                          body:
                                              jsonEncode({"user_id": userId}));
                                      Provider.of<LawyerDataProvider>(context,
                                              listen: false)
                                          .setData(ProfileData.fromJson(
                                              jsonDecode(resp.body)["result"]));
                                      Future.delayed(Duration(seconds: 2));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdvocateHomePage()));
                                    }
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const home(),));
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
                                  child: Text(
                                    'Update Data',
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: width * 0.05,
                                      letterSpacing: width * 0.002,
                                      // color: Colors.black,
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: height * 0.05,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])
            : Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )),
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');
    var dataAdvocate =
        AdvocatesList.data.where((element) => element.Uid == userId).first;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    var a = List.from(valuestopopulate.values);
    print(a);
    var list = [];
    print(services.remove(0).toString());
    for (int i = 0; i < services.length; i++) {
      list.add({
        "value": services[i],
      });
    }
    print(list);
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/updateCustomerInfo'),
        headers: headers,
        body: jsonEncode({
          "user_id": userId,
          'name': _fullNameController.text.toString(),
          'email': _emailController.text.toString(),
          'contact_number': _phoneNumberController.text.toString(),
          'address': _addressController.text.toString(),
          'profession': _professionController.text.toString(),
          'covered_area': _coveredAreaController.text.toString(),
          'region_id': regionsid,
          'country_id': countriesId,
          'city_id': citiesId,
          'probono': probonoId,
          'selectedFieldService': list,
          'age': _ageController.text,
          'gender': 0,
          "languages": ["English"],
          "user_type": widget.type.toString(),
          "img_url":
              "data:image/jpeg;base64,'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
        }));

    var data = jsonDecode(response.body);
    print(response.body);

    // print("new Data");
    // print(resp.body);
    if (response.statusCode == 200) {
      // print();

      if (data['code'] == 0) {
        Utils().toastMessage(data['description'].toString());
        getAdvocatesData();
        return;
        // print(
        //     AdvocatesList.data.where((element) => element.Uid == userId).first);
        // ignore: use_build_context_synchronously

        // Provider.of<LawyerDataProvider>(context, listen: false)
        //     .setData(ProfileData.fromJson(jsonDecode(resp.body)["result"]));
        // context
        //     .watch<LawyerDataProvider>()
        //     .setData(ProfileData.fromJson(jsonDecode(resp.body)["result"]));
      } else {
        Utils().toastMessage(data['description'].toString());
      }
      //
      // print(await response.stream.bytesToString());
    } else {
      print(response);
    }
  }

  Future<void> getData() async {
    var url = Uri.parse('http://www.advolocate.info/api/meta-info');

    var response = await http.get(url);

    print("printing latlng");
    print(response.statusCode);
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      data = json.decode(response.body);

      metaDataModel = MetaDataModel.fromJson(jsonDecode(response.body));

      for (int i = 0; i < metaDataModel.result!.regions!.length; i++) {
        regions.add(data!['result']['regions'][i]);
      }

      for (int i = 0; i < metaDataModel.result!.countries!.length; i++) {
        countries.add(data!['result']['countries'][i]);
      }

      for (int i = 0; i < metaDataModel.result!.probono!.length; i++) {
        probono.add(data!['result']['probono'][i]);
      }

      ct.add(data!['result']['cities'][0]);
      lenght = metaDataModel.result!.cities!.length;
    }

    setState(() {
      loading = false;
    });
  }

  void getCities(Map<String, dynamic> data, int lenght) {
    print('printing cities');
    print(countriesId);
    print(citiesId);
    print(cities);

    cities.clear();

    int countryID = int.parse(countriesId!);

    for (int i = 0; i < lenght - 1; i++) {
      if (data['result']['cities'][i]['country_id'] == countryID) {
        cities.add(data['result']['cities'][i]);
        // print(data['result']['cities'][i]['country_id'] == countryID);
      }
    }

    setState(() {});
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
    //Outline border type for TextFeild
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(
      color: Color(0xffFCD917),
      width: 1,
    ),
  );
}
