class SearchResultModel {
  int? _code;
  String? _description;
  Result? _result;

  SearchResultModel({int? code, String? description, Result? result}) {
    if (code != null) {
      this._code = code;
    }
    if (description != null) {
      this._description = description;
    }
    if (result != null) {
      this._result = result;
    }
  }

  int? get code => _code;
  set code(int? code) => _code = code;
  String? get description => _description;
  set description(String? description) => _description = description;
  Result? get result => _result;
  set result(Result? result) => _result = result;

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    print(json);
    _code = json['code'];
    _description = json['description'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this._code;
    data['description'] = this._description;
    if (this._result != null) {
      data['result'] = this._result!.toJson();
    }
    return data;
  }
}

class Result {
  int? _currentPage;
  List<Data>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  String? _nextPageUrl;
  String? _path;
  int? _perPage;
  Null? _prevPageUrl;
  int? _to;
  int? _total;

  Result(
      {int? currentPage,
      List<Data>? data,
      String? firstPageUrl,
      int? from,
      int? lastPage,
      String? lastPageUrl,
      String? nextPageUrl,
      String? path,
      int? perPage,
      Null? prevPageUrl,
      int? to,
      int? total}) {
    if (currentPage != null) {
      this._currentPage = currentPage;
    }
    if (data != null) {
      this._data = data;
    }
    if (firstPageUrl != null) {
      this._firstPageUrl = firstPageUrl;
    }
    if (from != null) {
      this._from = from;
    }
    if (lastPage != null) {
      this._lastPage = lastPage;
    }
    if (lastPageUrl != null) {
      this._lastPageUrl = lastPageUrl;
    }
    if (nextPageUrl != null) {
      this._nextPageUrl = nextPageUrl;
    }
    if (path != null) {
      this._path = path;
    }
    if (perPage != null) {
      this._perPage = perPage;
    }
    if (prevPageUrl != null) {
      this._prevPageUrl = prevPageUrl;
    }
    if (to != null) {
      this._to = to;
    }
    if (total != null) {
      this._total = total;
    }
  }

  int? get currentPage => _currentPage;
  set currentPage(int? currentPage) => _currentPage = currentPage;
  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;
  String? get firstPageUrl => _firstPageUrl;
  set firstPageUrl(String? firstPageUrl) => _firstPageUrl = firstPageUrl;
  int? get from => _from;
  set from(int? from) => _from = from;
  int? get lastPage => _lastPage;
  set lastPage(int? lastPage) => _lastPage = lastPage;
  String? get lastPageUrl => _lastPageUrl;
  set lastPageUrl(String? lastPageUrl) => _lastPageUrl = lastPageUrl;
  String? get nextPageUrl => _nextPageUrl;
  set nextPageUrl(String? nextPageUrl) => _nextPageUrl = nextPageUrl;
  String? get path => _path;
  set path(String? path) => _path = path;
  int? get perPage => _perPage;
  set perPage(int? perPage) => _perPage = perPage;
  Null? get prevPageUrl => _prevPageUrl;
  set prevPageUrl(Null? prevPageUrl) => _prevPageUrl = prevPageUrl;
  int? get to => _to;
  set to(int? to) => _to = to;
  int? get total => _total;
  set total(int? total) => _total = total;

  Result.fromJson(Map<String, dynamic> json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(Data.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['current_page'] = this._currentPage;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this._firstPageUrl;
    data['from'] = this._from;
    data['last_page'] = this._lastPage;
    data['last_page_url'] = this._lastPageUrl;
    data['next_page_url'] = this._nextPageUrl;
    data['path'] = this._path;
    data['per_page'] = this._perPage;
    data['prev_page_url'] = this._prevPageUrl;
    data['to'] = this._to;
    data['total'] = this._total;
    return data;
  }
}

class Data {
  int? _userId;
  String? _name;
  String? _cityName;
  String? _extraContactInfo;
  String? _gender;
  Null? _imgUrl;
  String? _profession;
  String? _coveredArea;
  String? _languages;
  String? _probono;
  String? _countryName;
  double? _lat;
  double? _lng;
  String? _services;

  Data(
      {int? userId,
      String? name,
      String? cityName,
      String? extraContactInfo,
      String? gender,
      Null? imgUrl,
      String? profession,
      String? coveredArea,
      String? languages,
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
  String? get coveredArea => _coveredArea;
  set coveredArea(String? coveredArea) => _coveredArea = coveredArea;
  String? get languages => _languages;
  set languages(String? languages) => _languages = languages;
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

  Data.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
