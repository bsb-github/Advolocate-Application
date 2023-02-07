import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileDataModel {
  int? code;
  String? description;
  Result? result;

  ProfileDataModel({this.code, this.description, this.result});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? userId;
  String? name;
  int? userType;
  String? email;
  String? contactNumber;
  String? address;
  int? probono;
  String? languages;
  String? gender;
  String? city;
  String? imgUrl;
  String? coveredArea;
  String? profession;
  String? services;
  SelectedCity? selectedCity;
  SelectedCity? selectedCountry;
  List<int>? selectedServices;

  Result(
      {this.userId,
      this.name,
      this.userType,
      this.email,
      this.contactNumber,
      this.address,
      this.probono,
      this.languages,
      this.gender,
      this.city,
      this.imgUrl,
      this.coveredArea,
      this.profession,
      this.services,
      this.selectedCity,
      this.selectedCountry,
      this.selectedServices});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    userType = json['user_type'];
    email = json['email'];
    contactNumber = json['contact_number'];
    address = json['address'];
    probono = json['probono'];
    languages = json['languages'];
    gender = json['gender'];
    city = json['city'];
    imgUrl = json['img_url'];
    coveredArea = json['covered_area'];
    profession = json['profession'];
    services = json['services'];
    selectedCity = json['selected_city'] != null
        ? new SelectedCity.fromJson(json['selected_city'])
        : null;
    selectedCountry = json['selected_country'] != null
        ? new SelectedCity.fromJson(json['selected_country'])
        : null;

    if (json['selected_services'] != null) {
      selectedServices = json['selected_services'].cast<int>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['contact_number'] = this.contactNumber;
    data['address'] = this.address;
    data['probono'] = this.probono;
    data['languages'] = this.languages;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['img_url'] = this.imgUrl;
    data['covered_area'] = this.coveredArea;
    data['profession'] = this.profession;
    data['services'] = this.services;
    if (this.selectedCity != null) {
      data['selected_city'] = this.selectedCity!.toJson();
    }
    if (this.selectedCountry != null) {
      data['selected_country'] = this.selectedCountry!.toJson();
    }
    if (this.selectedServices != null) {
      data['selected_services'] = this.selectedServices;
    }
    return data;
  }
}

class SelectedCity {
  int? value;
  String? label;

  SelectedCity({this.value, this.label});

  SelectedCity.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }
}

class ProfileDataList {
  static List<ProfileData> users = [
    ProfileData(
        name: 'name',
        address: 'address',
        city_name: 'city_name',
        email: 'email',
        contact_number: 'contact_number',
        link_type: 1,
        social_id: 'social_id',
        userType: 1,
        profession: '',
        covered_area: '',
        img_url: '',
        services: '')
  ];
}

class ProfileData {
  final String name;
  final String address;
  final String contact_number;
  final String email;
  final int link_type;
  final String city_name;
  final String profession;
  final String social_id;
  final int userType;
  final String covered_area;
  final String services;
  final String img_url;

  ProfileData({
    required this.name,
    required this.address,
    required this.city_name,
    required this.email,
    required this.contact_number,
    required this.link_type,
    required this.profession,
    required this.social_id,
    required this.userType,
    required this.covered_area,
    required this.services,
    required this.img_url,
  });

  // static ProfileData fromSnapshot(DocumentSnapshot snapshot) {
  //   return ProfileData(
  //       name: snapshot['name'],
  //       address: snapshot['address'],
  //       city_name: snapshot['city_name'],
  //       email: snapshot['email'],
  //       contact_number: snapshot['contact_number'],
  //       link_type: snapshot['link_type'],
  //       social_id: snapshot['social_id'],
  //       userType: snapshot['user_type'],
  //       profession: '');
  // }

  static ProfileData fromJson(Map<String, dynamic> Json) {
    // var Json = data["result"];
    return ProfileData(
        name: Json['name'],
        address: Json['address'],
        city_name: Json["city_name"] ?? "",
        email: Json['email'],
        contact_number: Json['contact_number'],
        link_type: Json["link_type"] ?? 0,
        social_id: Json["social_id"] ?? "",
        userType: 1,
        profession: Json["profession"] ?? "123",
        covered_area: Json["covered_area"] ?? "",
        img_url: Json["img_url"] ?? "",
        services: Json["services"].toString());
  }
}
