import 'package:advolocate_app/main.dart';
import 'package:advolocate_app/screens/HomePages.dart';
import 'package:advolocate_app/screens/search_results.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/meta_data_model.dart';
import '../Model/searchResultModel.dart';
import '../util/homepage/multiselect_dropdown.dart';
import '../util/widgets.dart';

import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //bottom Navigation bar
  int _selectedIndex = 0;
  var selectedVal = [
    0,
  ];
//  var services = [];

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
  List<dynamic> cities = [
    {"label": "City"}
  ];
  List<dynamic> probono = [];
  // List<dynamic> services = [];

  /////
  ///
  ///
  ///
  List services = [];
  String name = "City";
  bool rebuild = true;
  ValueNotifier valueNotifier = ValueNotifier(true);
  void incrementNotifier() {
    valueNotifier.value = !valueNotifier.value;
  }

  List<MultiSelectDialogItem<int>> multiItem = [];
  var Item = [];
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

  void populateMulti() {
    for (String v in valuestopopulate.values) {
      Item.add(v);
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
        return Container();
      },
    );

    // print('services as set');
    // print();
    selectedVal.clear();
    setState(() {
      // for (var element in selectedValues!.toList()) {
      //   selectedVal.add(element);
      // }
    });
    // debugPrint(selectedValues);
    print(selectedVal);
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
    populateMulti();

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
    // final listServices = sel.where((element) => element.);

    return Semantics(
      label: "homepage for User",
      child: SafeArea(
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
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushReplacement(
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
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  //image
                  Container(
                    height: 225,
                    child: Center(
                      child: const Image(
                        image: AssetImage('images/splashlogo.png'),
                        fit: BoxFit.cover,
                        height: 230,
                      ),
                    ),
                  ),

                  //text heading
                  Container(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      child: const Text(
                        'Search Advocate Here',
                        style: TextStyle(
                          fontSize: 22,
                          //  fontWeight: FontWeight.w600,
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
                            'Country',
                            countriesId,
                            countries,
                            (onChangedval) {
                              countriesId = onChangedval;
                              getCities(data!, lenght);
                            },
                            (onValidate) {
                              if (onValidate == null) {
                                return 'Required';
                              }
                              return null;
                            },
                            optionValue: 'value',
                            optionLabel: 'label',
                            textColor: Colors.black,
                            borderColor: Colors.white,
                            borderWidth: 1,
                            hintFontSize: width * 0.040,
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

                          // MultiSelectDialogField(
                          //   items: cities
                          //       .map((e) => MultiSelectItem(e, e["label"]))
                          //       .toList(),
                          //   searchable: true,
                          //   onConfirm: (values) {
                          //     print(values);
                          //   },

                          // ),
                          ValueListenableBuilder(
                            builder: (context, value, child) => Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 12),
                              child: DropdownSearch<String>(
                                onChanged: (value) {
                                  var obj = cities.where(
                                      (element) => element["label"] == value);
                                  setState(() {
                                    citiesId = obj.first["value"].toString();
                                  });
                                },
                                items: List.from(cities.map((e) => e["label"])),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    baseStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.035),
                                    dropdownSearchDecoration: InputDecoration(
                                        border: InputBorder.none)),
                                selectedItem: cities.length == 1
                                    ? name
                                    : cities.first["label"],
                                popupProps: const PopupProps.dialog(
                                    fit: FlexFit.loose,
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                            hintText: "Search"))),
                              ),
                            ),
                            valueListenable: valueNotifier,
                          ),

                          // FormHelper.dropDownWidget(
                          //   context,
                          //   '    City',
                          //   citiesId,
                          //   cities,
                          //   (onChangedval) {
                          //     print(cities.first['label']);
                          //     citiesId = onChangedval;
                          //   },
                          //   (onValidate) {
                          //     // if(onValidate == null)
                          //     // {
                          //     //   return '    Required';
                          //     // }
                          //     // return null;
                          //   },
                          //   optionValue: 'value',
                          //   optionLabel: 'label',
                          //   textColor: Colors.black,
                          //   borderColor: Colors.white,
                          //   borderWidth: 1,
                          //   hintFontSize: width * 0.045,
                          //   hintColor: Colors.black,
                          //   borderFocusColor: Colors.white,
                          //   validationColor: Colors.red,
                          // ),
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
                            'Select Probono',
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
                            hintFontSize: width * 0.040,
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
                          Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: MultipleSearchSelection(
                              items: Item, // List<Country>

                              fieldToCheck: (c) {
                                return c; // String
                              },
                              itemBuilder: (country) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 12,
                                      ),
                                      child: Text(
                                        country,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              pickedItemBuilder: (country) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      country,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onTapShowedItem: () {},
                              onPickedChange: (items) {},
                              onItemAdded: (item) {
                                services.add(Item.indexOf(item) + 15);
                              },
                              onItemRemoved: (item) {
                                services.remove(Item.indexOf(item) + 15);
                              },
                              onTapClearAll: () {
                                services.clear();
                              },
                              onTapSelectAll: () {
                                services.clear();
                                services.addAll(valuestopopulate.keys);
                              },
                              sortShowedItems: true,
                              sortPickedItems: true,
                              fuzzySearch: FuzzySearch.jaro,
                              itemsVisibility: ShowedItemsVisibility.alwaysOn,
                              title: Padding(
                                padding:
                                    EdgeInsets.only(bottom: 8.0, left: 4.0),
                                child: Text(
                                  'Field of Services',
                                  style: TextStyle(
                                    fontSize: width * 0.045,
                                  ),
                                ),
                              ),
                              showSelectAllButton: true,
                              // :
                              //     const EdgeInsets.symmetric(horizontal: 10),
                              maximumShowItemsHeight: 200,
                            ),
                          ),
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
                                  Colors.white, width, height, () async {
                                if (_formKey.currentState!.validate()) {
                                  print(countriesId);
                                  print(citiesId);
                                  fetchAdovate(int.parse(countriesId),
                                      int.parse(citiesId), int.parse(probonoId),
                                      servicesList: services);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ResultPage(
                                  //               countryID: int.parse(countriesId),
                                  //               cityID: int.parse(citiesId),
                                  //               probonoID: int.parse(probonoId),
                                  //               ServicesList: services,
                                  //             )));
                                }
                              }),
                              const Spacer(),
                              Button(
                                Colors.white,
                                'Reset',
                                const Color(0xffFCD917),
                                width,
                                height,
                                () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ));
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
      )),
    );
  }

  Future<void> fetchAdovate(int countryID, int cityID, int probonoID,
      {required List servicesList}) async {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var body;
    // var bodyApi
    print(servicesList);
    if (servicesList.isNotEmpty) {
      if (cityID != 0 && probonoID != -1) {
        print('print 1');
        body = jsonEncode({
          "country_id": countryID,
          "city_id": cityID,
          "probono": probonoID,
          "services": servicesList,
        });
      } else if (cityID != 0) {
        print('print 2');
        body = jsonEncode({
          "country_id": countryID,
          "city_id": cityID,
          "services": servicesList,
        });
      } else if (probonoID != -1) {
        print('print 3');
        body = jsonEncode({
          "country_id": countryID,
          "probono": probonoID,
          "services": servicesList,
        });
      } else {
        print('print 4');
        body = jsonEncode({
          "country_id": countryID,
          "services": servicesList,
        });
      }
      setState(() {});
    } else {
      if (cityID != 0 && probonoID != -1) {
        print('print 1');
        body = jsonEncode({
          "country_id": countryID,
          "city_id": cityID,
          "probono": probonoID,
        });
      } else if (cityID != 0) {
        print('print 2');
        body = jsonEncode({
          "country_id": countryID,
          "city_id": cityID,
        });
      } else if (probonoID != -1) {
        print('print 3');
        body = jsonEncode({
          "country_id": countryID,
          "probono": probonoID,
        });
      } else {
        print('print 4');
        body = jsonEncode({
          "country_id": countryID,
        });
      }
      setState(() {});
    }
    print(body);
    //?page=1
    var response = await http.post(
        Uri.parse('https://www.advolocate.info/api/searchAdvocate'),
        headers: headers,
        body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      if (data['code'] == 0) {
        Get.to(ResultPage(
            searchResultModel:
                SearchResultModel.fromJson(jsonDecode(response.body))));

        //   return;
      } else {
        // Utils().toastMessage('No Adovocate Found');
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Unavailable Advocates in your Area"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ))
                ],
              );
            });

        // ignore: use_build_context_synchronously
      }
    } else {
      print(response.body);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Unavailable Advocates"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
              ],
            );
          });
    }
  }

  Future<void> getData() async {
    var url = Uri.parse('https://www.advolocate.info/api/meta-info');

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
    loadingFun();
  }

  void getCities(Map<String, dynamic> data, int lenght) {
    print('printing cities');
    print(countriesId);
    print(citiesId);
    print(cities);

    // cities.clear();

    int countryID = int.parse(countriesId!);

    for (int i = 0; i < lenght - 1; i++) {
      if (data['result']['cities'][i]['country_id'] == countryID) {
        cities.add(data['result']['cities'][i]);
      }
    }
    print(cities.first);

    setState(() {});
  }
}
