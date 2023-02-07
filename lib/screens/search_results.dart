import 'dart:convert';
import 'dart:io';

import 'package:advolocate_app/Model/AdvocatesData.dart';

import 'package:advolocate_app/Model/searchResultModel.dart';
import 'package:advolocate_app/Providers/LawyerDataProvider.dart';
import 'package:advolocate_app/screens/AdvocateHomePage.dart';

import 'package:advolocate_app/screens/lawyer_page.dart';
import 'package:advolocate_app/util/search_result/LawyerWidget.dart';
import 'package:advolocate_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  final SearchResultModel searchResultModel;

  ResultPage({
    Key? key,
    required this.searchResultModel,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late int _selectedIndex = 0;

  // List<AdvocateData> advocateDataList = [];

  SearchResultModel searchResultModel = SearchResultModel();
  bool loading = true;

  String _baseUrl = 'http://www.advolocate.info/api/searchAdvocate';

  int _page = 1;

  final _scrollController = ScrollController();

  void _loadMore() {
    print('je');
  }

  @override
  void initState() {
    super.initState();

    print('init');
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        print('fetch');
      }
    });
  }

  // Future<SearchResultModel> fetchAdovate() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   final String? token = prefs.getString('token');
  //   final int? userId = prefs.getInt('userId');
  //   var headers = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json'
  //   };

  //   var body;
  //   // var bodyApi
  //   print(widget.probonoID);
  //   if (widget.cityID != 0 && widget.probonoID != -1) {
  //     print('print 1');
  //     body = jsonEncode({
  //       "country_id": widget.countryID,
  //       "city_id": widget.cityID,
  //       "probono": widget.probonoID,
  //       "services": widget.ServicesList,
  //     });
  //   } else if (widget.cityID != 0) {
  //     print('print 2');
  //     body = jsonEncode({
  //       "country_id": widget.countryID,
  //       "city_id": widget.cityID,
  //       "services": widget.ServicesList,
  //     });
  //   } else if (widget.probonoID != -1) {
  //     print('print 3');
  //     body = jsonEncode({
  //       "country_id": widget.countryID,
  //       "probono": widget.probonoID,
  //       "services": widget.ServicesList,
  //     });
  //   } else {
  //     print('print 4');
  //     body = jsonEncode({
  //       "country_id": widget.countryID,
  //       "services": widget.ServicesList,
  //     });
  //   }
  //   setState(() {});
  //   var response = await http.post(
  //       Uri.parse('http://www.advolocate.info/api/searchAdvocate?page=1'),
  //       headers: headers,
  //       body: body);

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body.toString());
  //     print(data);
  //     if (data['code'] == 0) {
  //       return SearchResultModel.fromJson(jsonDecode(response.body));
  //     } else {
  //       // Utils().toastMessage('No Adovocate Found');
  //       Get.snackbar("Unavailable",
  //           "Sorry advocates are not currently available in your area,",
  //           snackPosition: SnackPosition.BOTTOM,
  //           colorText: Colors.white,
  //           backgroundColor: Colors.red,
  //           margin: EdgeInsets.all(8));
  //       // ignore: use_build_context_synchronously
  //       Navigator.pop(context);
  //       throw Exception("Failed to load  post!");
  //     }
  //   } else {
  //     print(response.body);
  //     Get.snackbar("Unavailable", "Unable to Show Advocates",
  //         snackPosition: SnackPosition.BOTTOM,
  //         colorText: Colors.white,
  //         backgroundColor: Colors.red,
  //         margin: EdgeInsets.all(8));
  //     throw Exception("Failed to load  post!");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    SearchResultModel searchResult = widget.searchResultModel;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        elevation: 0,
        title: const Text(
          'Lawyers',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: height * 0.04, left: width * 0.08, right: width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Lawyers',
                style: TextStyle(
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text('View Lawyer Profile',
                  style: TextStyle(
                    fontSize: width * 0.065,
                  )),
              ListView.builder(
                controller: _scrollController,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: searchResult.result!.data!.length,
                itemBuilder: (context, index) {
                  var data = searchResult.result!.data![index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: GestureDetector(
                      onTap: () {
                        var Data = AdvocatesList.data
                            .where((element) => element.uid == data.userId);
                        Provider.of<LawyerDataProvider>(context, listen: false)
                            .setAdvData(Data.first);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LawyerPage(
                                  name: Data.first.name,
                                  email: Data.first.email,
                                  information: Data.first.services,
                                  address: Data.first.address,
                                  probono: Data.first.probono,
                                  contactNumber: Data.first.contact),
                            ));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => LawyerPage(
                        //             name: Data.first.name,
                        //             contactNumber: Data.first.contact,
                        //             email: Data.first.email,
                        //             information: Data.first.services,
                        //             address: Data.first.address,
                        //             probono: Data.first.probono)));
                      },
                      child: Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: LawyerWidget(
                          name: searchResult.result!.data![index].name!,
                          address: searchResult.result!.data![index].cityName!,
                          noOfClients: "0",
                          imgUrl:
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                          rating: index,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _scrollListener() {
    print('sdadas');
  }
}
