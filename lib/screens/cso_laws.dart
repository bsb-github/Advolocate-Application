import 'package:advolocate_app/Model/meta_data_model.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../util/widgets.dart';

class CsoLaws extends StatefulWidget {
  const CsoLaws({Key? key}) : super(key: key);

  @override
  State<CsoLaws> createState() => _CsoLawsState();
}

class _CsoLawsState extends State<CsoLaws> {
  List<dynamic> countries = [];
  List<dynamic> region = [];
  String? countryid;
  String? regionid;
  late int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    countries.add({'id': 1, 'label': 'South Asia'});

    region.add({'id': 1, 'label': 'Pakistan'});
    region.add({'id': 2, 'label': 'Bangladesh'});
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
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'CSO Laws',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
              top: height * 0.04, left: width * 0.08, right: width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CSO Laws',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const Text('Search CSO Here', style: TextStyle(fontSize: 18)),
              SizedBox(
                height: height * 0.05,
              ),

              //Country
              FormHelper.dropDownWidget(
                context,
                'Country',
                countryid,
                countries,
                (onChangedval) {
                  countryid = onChangedval;
                },
                (onValidate) {
                  return null;
                },
                optionValue: 'id',
                optionLabel: 'label',
                borderColor: Colors.white,
                hintFontSize: width * 0.046,
                hintColor: Colors.black,
                borderFocusColor: Colors.white,
                validationColor: Theme.of(context).primaryColor,
              ),
              Divider(
                thickness: width * 0.006,
                color: Theme.of(context).primaryColor,
                indent: width * 0.03,
                endIndent: width * 0.03,
                height: height * 0.03,
              ),
              SizedBox(
                height: height * 0.03,
              ),

              //region
              FormHelper.dropDownWidget(
                context,
                'Region',
                regionid,
                region,
                (onChangedval) {
                  regionid = onChangedval;
                },
                (onValidate) {
                  return null;
                },
                optionValue: 'id',
                optionLabel: 'label',
                borderColor: Colors.white,
                hintFontSize: width * 0.046,
                hintColor: Colors.black,
                borderFocusColor: Colors.white,
                validationColor: Theme.of(context).primaryColor,
              ),
              Divider(
                thickness: width * 0.006,
                color: Theme.of(context).primaryColor,
                indent: width * 0.03,
                endIndent: width * 0.03,
                height: height * 0.03,
              ),

              SizedBox(
                height: height * 0.04,
              ),

              Row(
                children: [
                  Button(const Color(0xffFCD917), 'Search', Colors.white, width,
                      height, () {}),
                  const Spacer(),
                  Button(Colors.white, 'Reset', const Color(0xffFCD917), width,
                      height, () {
                    setState(() {
                      //  countries=[];
                      region = [];
                      countryid = '';
                      regionid = '';
                    });
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
