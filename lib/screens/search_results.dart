import 'dart:convert';

import 'package:advolocate_app/Model/AdvocatesData.dart';

import 'package:advolocate_app/Model/searchResultModel.dart';

import 'package:advolocate_app/screens/lawyer_page.dart';
import 'package:advolocate_app/util/search_result/LawyerWidget.dart';
import 'package:advolocate_app/utils/utils.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');
    var headers = {
      'Authorization': 'Bearer $token',
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
    setState(() {});
    var response = await http.post(
        Uri.parse('http://www.advolocate.info/api/searchAdvocate?page=1'),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      if (data['code'] == 0) {
        return SearchResultModel.fromJson(jsonDecode(response.body));
      } else {
        Utils().toastMessage('No Adovocate Found');
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        throw Exception("Failed to load  post!");
      }
    } else {
      print(response.body);
      Utils().toastMessage(response.statusCode.toString());
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
                          var data = snapshot.data!.result!.data![index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: GestureDetector(
                              onTap: () {
                                var Data = AdvocatesList.data.where(
                                    (element) => element.uid == data.userId);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LawyerPage(
                                            name: Data.first.name,
                                            contactNumber: Data.first.contact,
                                            email: Data.first.email,
                                            information: Data.first.services,
                                            address: Data.first.address,
                                            probono: Data.first.probono)));
                              },
                              child: Card(
                                elevation: 8.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: LawyerWidget(
                                  name:
                                      snapshot.data!.result!.data![index].name!,
                                  address: snapshot
                                      .data!.result!.data![index].cityName!,
                                  noOfClients: "0",
                                  imgUrl:
                                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                  rating: index,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                    );
                  }),
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
