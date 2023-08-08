class ResultModal {
  int? _userId;
  String? _name;
  String? _cityName;
  String? _extraContactInfo;
  String? _gender;
  Null? _imgUrl;
  String? _profession;
  Null? _coveredArea;
  Null? _languages;
  String? _probono;
  String? _countryName;
  double? _lat;
  double? _lng;
  String? _services;

  ResultModal(
      {int? userId,
      String? name,
      String? cityName,
      String? extraContactInfo,
      String? gender,
      Null? imgUrl,
      String? profession,
      Null? coveredArea,
      Null? languages,
      String? probono,
      String? countryName,
      double? lat,
      double? lng,
      String? services}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (name != null) {
      this._name = name;
    }
    if (cityName != null) {
      this._cityName = cityName;
    }
    if (extraContactInfo != null) {
      this._extraContactInfo = extraContactInfo;
    }
    if (gender != null) {
      this._gender = gender;
    }
    if (imgUrl != null) {
      this._imgUrl = imgUrl;
    }
    if (profession != null) {
      this._profession = profession;
    }
    if (coveredArea != null) {
      this._coveredArea = coveredArea;
    }
    if (languages != null) {
      this._languages = languages;
    }
    if (probono != null) {
      this._probono = probono;
    }
    if (countryName != null) {
      this._countryName = countryName;
    }
    if (lat != null) {
      this._lat = lat;
    }
    if (lng != null) {
      this._lng = lng;
    }
    if (services != null) {
      this._services = services;
    }
  }

  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get cityName => _cityName;
  set cityName(String? cityName) => _cityName = cityName;
  String? get extraContactInfo => _extraContactInfo;
  set extraContactInfo(String? extraContactInfo) =>
      _extraContactInfo = extraContactInfo;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  Null? get imgUrl => _imgUrl;
  set imgUrl(Null? imgUrl) => _imgUrl = imgUrl;
  String? get profession => _profession;
  set profession(String? profession) => _profession = profession;
  Null? get coveredArea => _coveredArea;
  set coveredArea(Null? coveredArea) => _coveredArea = coveredArea;
  Null? get languages => _languages;
  set languages(Null? languages) => _languages = languages;
  String? get probono => _probono;
  set probono(String? probono) => _probono = probono;
  String? get countryName => _countryName;
  set countryName(String? countryName) => _countryName = countryName;
  double? get lat => _lat;
  set lat(double? lat) => _lat = lat;
  double? get lng => _lng;
  set lng(double? lng) => _lng = lng;
  String? get services => _services;
  set services(String? services) => _services = services;

  ResultModal.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _name = json['name'];
    _cityName = json['city_name'];
    _extraContactInfo = json['extra_contact_info'];
    _gender = json['gender'];
    _imgUrl = json['img_url'];
    _profession = json['profession'];
    _coveredArea = json['covered_area'];
    _languages = json['languages'];
    _probono = json['probono'];
    _countryName = json['country_name'];
    _lat = json['lat'];
    _lng = json['lng'];
    _services = json['services'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['name'] = this._name;
    data['city_name'] = this._cityName;
    data['extra_contact_info'] = this._extraContactInfo;
    data['gender'] = this._gender;
    data['img_url'] = this._imgUrl;
    data['profession'] = this._profession;
    data['covered_area'] = this._coveredArea;
    data['languages'] = this._languages;
    data['probono'] = this._probono;
    data['country_name'] = this._countryName;
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    data['services'] = this._services;
    return data;
  }
}
