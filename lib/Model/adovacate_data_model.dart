class AdvocateData {
  int? _code;
  String? _description;
  List<AdvocateResult>? _result;

  AdvocateData({int? code, String? description, List<AdvocateResult>? result}) {
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
  List<AdvocateResult>? get result => _result;
  set result(List<AdvocateResult>? result) => _result = result;

  AdvocateData.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _description = json['description'];
    if (json['result'] != null) {
      _result = <AdvocateResult>[];
      AdvocateResult.fromJson(json['result']);
      // json['result'].forEach((v) {
      //   _result!.add(new AdvocateResult.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['description'] = this._description;
    if (this._result != null) {
      data['result'] = this._result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdvocateResult {
  int? _userId;
  String? _name;
  String? _email;
  String? _contactNumber;
  String? _userName;
  String? _address;
  String? _extraContactInfo;
  String? _coveredArea;
  String? _profession;
  int? _probono;
  String? _languages;
  int? _status;
  String? _gender;
  String? _country;
  String? _city;
  String? _services;
  List<int>? _fieldOfService;
  List<Licences>? _licences;

  AdvocateResult(
      {int? userId,
      String? name,
      String? email,
      String? contactNumber,
      String? userName,
      String? address,
      String? extraContactInfo,
      String? coveredArea,
      String? profession,
      int? probono,
      String? languages,
      int? status,
      String? gender,
      String? country,
      String? city,
      String? services,
      List<int>? fieldOfService,
      List<Licences>? licences}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (contactNumber != null) {
      this._contactNumber = contactNumber;
    }
    if (userName != null) {
      this._userName = userName;
    }
    if (address != null) {
      this._address = address;
    }
    if (extraContactInfo != null) {
      this._extraContactInfo = extraContactInfo;
    }
    if (coveredArea != null) {
      this._coveredArea = coveredArea;
    }
    if (profession != null) {
      this._profession = profession;
    }
    if (probono != null) {
      this._probono = probono;
    }
    if (languages != null) {
      this._languages = languages;
    }
    if (status != null) {
      this._status = status;
    }
    if (gender != null) {
      this._gender = gender;
    }
    if (country != null) {
      this._country = country;
    }
    if (city != null) {
      this._city = city;
    }
    if (services != null) {
      this._services = services;
    }
    if (fieldOfService != null) {
      this._fieldOfService = fieldOfService;
    }
    if (licences != null) {
      this._licences = licences;
    }
  }

  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get contactNumber => _contactNumber;
  set contactNumber(String? contactNumber) => _contactNumber = contactNumber;
  String? get userName => _userName;
  set userName(String? userName) => _userName = userName;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get extraContactInfo => _extraContactInfo;
  set extraContactInfo(String? extraContactInfo) =>
      _extraContactInfo = extraContactInfo;
  String? get coveredArea => _coveredArea;
  set coveredArea(String? coveredArea) => _coveredArea = coveredArea;
  String? get profession => _profession;
  set profession(String? profession) => _profession = profession;
  int? get probono => _probono;
  set probono(int? probono) => _probono = probono;
  String? get languages => _languages;
  set languages(String? languages) => _languages = languages;
  int? get status => _status;
  set status(int? status) => _status = status;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get country => _country;
  set country(String? country) => _country = country;
  String? get city => _city;
  set city(String? city) => _city = city;
  String? get services => _services;
  set services(String? services) => _services = services;
  List<int>? get fieldOfService => _fieldOfService;
  set fieldOfService(List<int>? fieldOfService) =>
      _fieldOfService = fieldOfService;
  List<Licences>? get licences => _licences;
  set licences(List<Licences>? licences) => _licences = licences;

  AdvocateResult.fromJson(Map<String, dynamic> json) {
    //
    print(json);
    _userId = json['user_id'] ?? 0;
    _name = json['name'] ?? "";
    _email = json['email'] ?? "";
    _contactNumber = json['contact_number'] ?? "";
    _userName = json['user_name'] ?? "";
    _address = json['address'] ?? "";
    _extraContactInfo = json['extra_contact_info'] ?? "";
    _coveredArea = json['covered_area'] ?? "";
    _profession = json['profession'] ?? "";
    _probono = json['probono'] ?? 0;
    _languages = json['languages'] ?? "";
    _status = json['status'] ?? 0;
    _gender = json['gender'] ?? "";
    _country = json['country'] ?? "";
    _city = json['city'] ?? "";
    _services = json['services'];
    if (json['field_of_service'] != null) {
      _fieldOfService = json['field_of_service'].cast<int>();
    }

    if (json['licences'] != null) {
      _licences = <Licences>[];
      json['licences'].forEach((v) {
        _licences!.add(new Licences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['name'] = this._name;
    data['email'] = this._email;
    data['contact_number'] = this._contactNumber;
    data['user_name'] = this._userName;
    data['address'] = this._address;
    data['extra_contact_info'] = this._extraContactInfo;
    data['covered_area'] = this._coveredArea;
    data['profession'] = this._profession;
    data['probono'] = this._probono;
    data['languages'] = this._languages;
    data['status'] = this._status;
    data['gender'] = this._gender;
    data['country'] = this._country;
    data['city'] = this._city;
    data['services'] = this._services;
    data['field_of_service'] = this._fieldOfService;
    if (this._licences != null) {
      data['licences'] = this._licences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Licences {
  int? _id;
  String? _imageName;
  String? _imageUrl;

  Licences({int? id, String? imageName, String? imageUrl}) {
    if (id != null) {
      this._id = id;
    }
    if (imageName != null) {
      this._imageName = imageName;
    }
    if (imageUrl != null) {
      this._imageUrl = imageUrl;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get imageName => _imageName;
  set imageName(String? imageName) => _imageName = imageName;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;

  Licences.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _imageName = json['image_name'];
    _imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['image_name'] = this._imageName;
    data['image_url'] = this._imageUrl;
    return data;
  }
}
