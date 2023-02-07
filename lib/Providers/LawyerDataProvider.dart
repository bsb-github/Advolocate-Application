import 'package:advolocate_app/Model/AdvocatesData.dart';
import 'package:advolocate_app/Model/adovacate_data_model.dart';
import 'package:advolocate_app/Model/profile_data_model.dart';
import 'package:flutter/widgets.dart';

class LawyerDataProvider extends ChangeNotifier {
  ProfileData _data = new ProfileData(
      name: "",
      address: "",
      city_name: "city_name",
      email: "email",
      contact_number: "contact_number",
      link_type: 0,
      profession: "profession",
      social_id: "social_id",
      userType: 1,
      covered_area: "covered_area",
      services: "services",
      img_url: "img_url");

  ProfileData get data => _data;
  void setData(ProfileData data) {
    _data = data;
  }

  AdvocatesData _advData = AdvocatesData(
      email: "",
      probono: "",
      uid: 0,
      contact: "",
      name: "",
      address: "",
      extra_contact_info: "",
      languages: "",
      status: 0,
      coveredArea: "",
      services: "",
      city: "",
      profession: "",
      country: '');
  AdvocatesData get advData => _advData;

  void setAdvData(AdvocatesData data) {
    _advData = data;
    notifyListeners();
  }
}
