import 'package:advolocate_app/Model/profile_data_model.dart';
import 'package:advolocate_app/main.dart';
import 'package:advolocate_app/screens/cso_laws.dart';
import 'package:advolocate_app/screens/privacy_policy.dart';
import 'package:advolocate_app/screens/search_results.dart';
import 'package:advolocate_app/screens/user_profile.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Model/meta_data_model.dart';
import '../util/homepage/multiselect_dropdown.dart';
import '../util/widgets.dart';

import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //bottom Navigation bar
  int _selectedIndex = 0;

  MetaDataModel metaDataModel = MetaDataModel();
  void navigateBottomBar(int index) {
    _selectedIndex = index;
    setState(() {
      _selectedIndex = index;
      // if (index == 0) {
      //   Navigator.pushNamed(context, '/home');
      // } else if (index == 1) {
      //   Navigator.pushNamed(context, '/profile');
      // } else if (index == 3) {
      //   Navigator.pushNamed(context, '/cso_laws');
      // } else if (index == 2) {
      //   Navigator.pushNamed(context, '/privacy_policy');
      // }
    });
  }

  String countriesId = '';
  String citiesId = '0';
  String probonoId = '-1';
  String servicesId = '-1';

  List<dynamic> regions = [];
  List<dynamic> countries = [];
  List<dynamic> cities = [];
  List<dynamic> probono = [];
  // List<dynamic> services = [];

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
    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: services.isEmpty ? {0} : sel,
        );
      },
    );

    // print('services as set');
    // print(sel);
    // debugPrint(selectedValues);
    getvaluefromkey(selectedValues!);
  }

  void getvaluefromkey(Set<int> selection) {
    sel = selection;
    for (int x in selection.toList()) {
      services = selection.toList();

      // print(valuestopopulate[x]);
    }
  }

  @override
  void initState() {
    super.initState();

    if (metaDataModel.result == null) {
      getData();
    } else {
      loadingFun();
    }
  }

  void loadingFun() {
    setState(() {
      loading = false;
    });
  }

  bool loading = true;

  // ==========================================================================================================
  _logout() async {
    await FacebookAuth.instance.logOut();
  }

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? data;
  int lenght = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFCD917),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (ProfileDataList.users[0].userType == 1) {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  //googleSignIn.disconnect();
                } else {
                  //_logout();
                }
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
      ),
      body: loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                //image
                SizedBox(
                  // padding: EdgeInsets.only(top: 12,bottom: 12),
                  width: width,
                  height: height / 3,
                  child: const Image(
                    image: AssetImage('asset/advo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),

                //text heading
                Container(
                    padding: EdgeInsets.only(left: width * 0.1),
                    child: Text(
                      'Search Advocate Here',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        // letterSpacing: 1
                      ),
                    )),

                //dropdown selector
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1, vertical: height * 0.01),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //country

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
                          borderColor: Colors.white,
                          borderWidth: 1,
                          hintFontSize: width * 0.045,
                          hintColor: Colors.black,
                          borderFocusColor: Colors.white,
                          validationColor: Colors.red,
                        ),
                        Divider(
                          thickness: width * 0.006,
                          color: Theme.of(context).primaryColor,
                          indent: width * 0.03,
                          endIndent: width * 0.03,
                          height: height * 0.03,
                        ),

                        //State
                        FormHelper.dropDownWidget(
                          context,
                          '    City',
                          citiesId,
                          cities,
                          (onChangedval) {
                            citiesId = onChangedval;
                          },
                          (onValidate) {
                            // if(onValidate == null)
                            // {
                            //   return '    Required';
                            // }
                            // return null;
                          },
                          optionValue: 'value',
                          optionLabel: 'label',
                          textColor: Colors.black,
                          borderColor: Colors.white,
                          borderWidth: 1,
                          hintFontSize: width * 0.045,
                          hintColor: Colors.black,
                          borderFocusColor: Colors.white,
                          validationColor: Colors.red,
                        ),
                        Divider(
                          thickness: width * 0.006,
                          color: Theme.of(context).primaryColor,
                          indent: width * 0.03,
                          endIndent: width * 0.03,
                          height: height * 0.03,
                        ),

                        //field of services
                        FormHelper.dropDownWidget(
                          context,
                          '    Select Probono',
                          probonoId,
                          probono,
                          (onChangedval) {
                            probonoId = onChangedval;
                          },
                          (onValidate) {
                            // if(onValidate == null)
                            // {
                            //   return '   Required';
                            // }
                            // return null;
                          },
                          optionValue: 'value',
                          optionLabel: 'label',
                          textColor: Colors.black,
                          borderColor: Colors.white,
                          borderWidth: 1,
                          hintFontSize: width * 0.045,
                          hintColor: Colors.black,
                          borderFocusColor: Colors.white,
                          validationColor: Colors.red,
                        ),

                        Divider(
                          thickness: width * 0.006,
                          color: Theme.of(context).primaryColor,
                          indent: width * 0.03,
                          endIndent: width * 0.03,
                          height: height * 0.03,
                        ),
                        InkWell(
                            child: Container(
                              margin: EdgeInsets.only(
                                left: width * 0.05,
                                //    right: width * 0.05
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                //color: Colors.pink,
                                // border:Border.all(
                                //   color: Color(0xffFCD917),
                                //
                                // ),
                              ),
                              padding: EdgeInsets.only(
                                  left: width * 0.068,
                                  top: height * 0.02,
                                  // right: width * 0.065,
                                  bottom: height * 0.01),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Field Of Services',
                                      style: TextStyle(
                                        fontSize: width * 0.045,
                                        color: Colors.black,
                                      )),
                                  SizedBox(
                                    width: width * 0.22,
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => _showMultiSelect(context)),
                        //field of nature
                        // FormHelper.dropDownWidget(
                        //   context,
                        //   'Field Of Nature',
                        //   natureid,
                        //   fNature,
                        //   (onChangedval) {
                        //     natureid = onChangedval;
                        //   },
                        //   (onValidateVal) {
                        //     if (onValidateVal == null) {
                        //       return 'Please select a field';
                        //     }
                        //     return null;
                        //   },
                        //   optionValue: 'id',
                        //   optionLabel: 'label',
                        //   borderColor: Colors.white,
                        //   hintFontSize: width*0.046,
                        //   hintColor: Colors.black,
                        //   borderFocusColor: Colors.white,
                        //   validationColor: Theme.of(context).primaryColor,
                        // ),
                        Divider(
                          thickness: width * 0.006,
                          color: Theme.of(context).primaryColor,
                          indent: width * 0.03,
                          endIndent: width * 0.03,
                          height: height * 0.03,
                        ),
                        const SizedBox(
                            // height: height*0.01,
                            ),
                        //buttons
                        Row(
                          children: [
                            Button(const Color(0xffFCD917), 'Search',
                                Colors.white, width, height, () {
                              if (_formKey.currentState!.validate()) {
                                print(countriesId);
                                print(citiesId);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                              countryID: int.parse(countriesId),
                                              cityID: int.parse(citiesId),
                                              probonoID: int.parse(probonoId),
                                            )));
                              }
                            }),
                            const Spacer(),
                            Button(
                              Colors.white,
                              'Reset',
                              const Color(0xffFCD917),
                              width,
                              height,
                              () {
                                //print('workgin reset');
                                setState(() {
                                  countriesId = '';
                                  // countries=[];
                                  cities = [];
                                  services = [];
                                  probono = [];
                                  probonoId = '2';
                                  loading = true;
                                });
                                getData();
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    ));
  }

  Future<void> getData() async {
    var url = Uri.parse('http://www.advolocate.info/api/meta-info');

    var response = await http.get(url);

    print("printing latlng");
    print(response.statusCode);
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      data = json.decode(response.body);

      // print(data['result']['regions']);

      // print(data!['result']['services']);

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
      }
    }

    setState(() {});
  }
}
