import 'dart:convert';

import 'package:advolocate_app/Model/adovacate_data_model.dart';
import 'package:advolocate_app/Model/searchResultModel.dart';
import 'package:advolocate_app/config.dart';
import 'package:advolocate_app/utils/utils.dart';
import 'package:flutter/foundation.dart';

import '../util/search_result/lawyer_tile.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  int countryID;
  int cityID;
  int probonoID;

  ResultPage(
      {Key? key, this.countryID = 0, this.cityID = 0, this.probonoID = -1})
      : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late int _selectedIndex = 0;

  // List<AdvocateData> advocateDataList = [];
  late Future<SearchResultModel> searchResult = fetchAdovate();
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

  Future<SearchResultModel> fetchAdovate() async {
    var headers = {
      'Authorization': 'Bearer $searchAdvocateToken',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var body;
    print(widget.probonoID);
    if (widget.cityID != 0 && widget.probonoID != -1) {
      print('print 1');
      body = jsonEncode({
        "country_id": widget.countryID,
        "city_id": widget.cityID,
        "probono": widget.probonoID
      });
    } else if (widget.cityID != 0) {
      print('print 2');
      body = jsonEncode({
        "country_id": widget.countryID,
        "city_id": widget.cityID,
      });
    } else if (widget.probonoID != -1) {
      print('print 3');
      body = jsonEncode(
          {"country_id": widget.countryID, "probono": widget.probonoID});
    } else {
      print('print 4');
      body = jsonEncode({
        "country_id": widget.countryID,
      });
    }

    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/searchAdvocate?page=1'),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      if (data['code'] == 0) {
        return SearchResultModel.fromJson(jsonDecode(response.body));
      } else {
        Utils().toastMessage('No Adovocate Found');
        Navigator.pop(context);
        return SearchResultModel.fromJson(jsonDecode(response.body));
      }
    } else {
      throw Exception("Failed to load  post!");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
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
                  Text(
                    'View Lawyer Profile',
                    style: TextStyle(
                      fontSize: width * 0.065,
                    ),
                  ),
                  FutureBuilder<SearchResultModel>(
                      future: searchResult,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            controller: _scrollController,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.result!.data!.length,
                            itemBuilder: (context, index) {
                              return LawyerTile(
                                name: snapshot.data!.result!.data![index].name!,
                                city: snapshot
                                    .data!.result!.data![index].cityName!,
                                profession: snapshot.data!.result!.data![index]
                                            .profession ==
                                        null
                                    ? 'NA'
                                    : snapshot
                                        .data!.result!.data![index].profession!,
                                services: snapshot.data!.result!.data![index]
                                            .services !=
                                        null
                                    ? snapshot
                                        .data!.result!.data![index].services!
                                    : "NA",
                                probono: snapshot.data!.result!.data![index]
                                            .probono !=
                                        null
                                    ? snapshot
                                        .data!.result!.data![index].probono!
                                    : "NA",
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.black,
              // currentIndex: _selectedIndex,
              onTap: navigateBottomBar,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.privacy_tip), label: 'Privacy Policy'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.description_outlined), label: 'CSO Laws'),
              ])),
    );
  }

  void navigateBottomBar(int index) {
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

  void _scrollListener() {
    print('sdadas');
  }
}
