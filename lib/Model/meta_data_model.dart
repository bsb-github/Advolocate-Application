class MetaDataModel {
  int? _code;
  String? _description;
  Result? _result;

  MetaDataModel({int? code, String? description, Result? result}) {
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

  MetaDataModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _description = json['description'];
    _result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['description'] = this._description;
    if (this._result != null) {
      data['result'] = this._result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Regions>? _regions;
  List<Countries>? _countries;
  List<Cities>? _cities;
  List<Probono>? _probono;
  List<Services>? _services;

  Result(
      {List<Regions>? regions,
        List<Countries>? countries,
        List<Cities>? cities,
        List<Probono>? probono,
        List<Services>? services}) {
    if (regions != null) {
      this._regions = regions;
    }
    if (countries != null) {
      this._countries = countries;
    }
    if (cities != null) {
      this._cities = cities;
    }
    if (probono != null) {
      this._probono = probono;
    }
    if (services != null) {
      this._services = services;
    }
  }

  List<Regions>? get regions => _regions;
  set regions(List<Regions>? regions) => _regions = regions;
  List<Countries>? get countries => _countries;
  set countries(List<Countries>? countries) => _countries = countries;
  List<Cities>? get cities => _cities;
  set cities(List<Cities>? cities) => _cities = cities;
  List<Probono>? get probono => _probono;
  set probono(List<Probono>? probono) => _probono = probono;
  List<Services>? get services => _services;
  set services(List<Services>? services) => _services = services;

  Result.fromJson(Map<String, dynamic> json) {
    if (json['regions'] != null) {
      _regions = <Regions>[];
      json['regions'].forEach((v) {
        _regions!.add(new Regions.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      _countries = <Countries>[];
      json['countries'].forEach((v) {
        _countries!.add(new Countries.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      _cities = <Cities>[];
      json['cities'].forEach((v) {
        _cities!.add(new Cities.fromJson(v));
      });
    }
    if (json['probono'] != null) {
      _probono = <Probono>[];
      json['probono'].forEach((v) {
        _probono!.add(new Probono.fromJson(v));
      });
    }
    if (json['services'] != null) {
      _services = <Services>[];
      json['services'].forEach((v) {
        _services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._regions != null) {
      data['regions'] = this._regions!.map((v) => v.toJson()).toList();
    }
    if (this._countries != null) {
      data['countries'] = this._countries!.map((v) => v.toJson()).toList();
    }
    if (this._cities != null) {
      data['cities'] = this._cities!.map((v) => v.toJson()).toList();
    }
    if (this._probono != null) {
      data['probono'] = this._probono!.map((v) => v.toJson()).toList();
    }
    if (this._services != null) {
      data['services'] = this._services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? _value;
  String? _label;


  Regions({int? value, String? label, Null? regionCode}) {
    if (value != null) {
      this._value = value;
    }
    if (label != null) {
      this._label = label;
    }

  }

  int? get value => _value;
  set value(int? value) => _value = value;
  String? get label => _label;
  set label(String? label) => _label = label;



  Services.fromJson(Map<String, dynamic> json) {
    _value = json['value'];
    _label = json['label'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this._value;
    data['label'] = this._label;

    return data;
  }
}
class Regions {
  int? _value;
  String? _label;
  Null? _regionCode;

  Regions({int? value, String? label, Null? regionCode}) {
    if (value != null) {
      this._value = value;
    }
    if (label != null) {
      this._label = label;
    }
    if (regionCode != null) {
      this._regionCode = regionCode;
    }
  }

  int? get value => _value;
  set value(int? value) => _value = value;
  String? get label => _label;
  set label(String? label) => _label = label;
  Null? get regionCode => _regionCode;
  set regionCode(Null? regionCode) => _regionCode = regionCode;

  Regions.fromJson(Map<String, dynamic> json) {
    _value = json['value'];
    _label = json['label'];
    _regionCode = json['region_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this._value;
    data['label'] = this._label;
    data['region_code'] = this._regionCode;
    return data;
  }
}

class Countries {
  int? _value;
  String? _label;
  String? _regionId;
  String? _alias;

  Countries({int? value, String? label, String? regionId, String? alias}) {
    if (value != null) {
      this._value = value;
    }
    if (label != null) {
      this._label = label;
    }
    if (regionId != null) {
      this._regionId = regionId;
    }
    if (alias != null) {
      this._alias = alias;
    }
  }

  int? get value => _value;
  set value(int? value) => _value = value;
  String? get label => _label;
  set label(String? label) => _label = label;
  String? get regionId => _regionId;
  set regionId(String? regionId) => _regionId = regionId;
  String? get alias => _alias;
  set alias(String? alias) => _alias = alias;

  Countries.fromJson(Map<String, dynamic> json) {
    _value = json['value'];
    _label = json['label'];
    _regionId = json['region_id'];
    _alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this._value;
    data['label'] = this._label;
    data['region_id'] = this._regionId;
    data['alias'] = this._alias;
    return data;
  }
}

class Cities {
  int? _value;
  String? _label;
  int? _districtId;
  int? _countryId;
  int? _provinceId;
  int? _regionId;
  dynamic? _lat;
  dynamic? _lng;

  Cities(
      {int? value,
        String? label,
        int? districtId,
        int? countryId,
        int? provinceId,
        int? regionId,
        dynamic? lat,
        dynamic? lng}) {
    if (value != null) {
      this._value = value;
    }
    if (label != null) {
      this._label = label;
    }
    if (districtId != null) {
      this._districtId = districtId;
    }
    if (countryId != null) {
      this._countryId = countryId;
    }
    if (provinceId != null) {
      this._provinceId = provinceId;
    }
    if (regionId != null) {
      this._regionId = regionId;
    }
    if (lat != null) {
      this._lat = lat;
    }
    if (lng != null) {
      this._lng = lng;
    }
  }

  int? get value => _value;
  set value(int? value) => _value = value;
  String? get label => _label;
  set label(String? label) => _label = label;
  int? get districtId => _districtId;
  set districtId(int? districtId) => _districtId = districtId;
  int? get countryId => _countryId;
  set countryId(int? countryId) => _countryId = countryId;
  int? get provinceId => _provinceId;
  set provinceId(int? provinceId) => _provinceId = provinceId;
  int? get regionId => _regionId;
  set regionId(int? regionId) => _regionId = regionId;
  double? get lat => _lat;
  set lat(double? lat) => _lat = lat;
  double? get lng => _lng;
  set lng(double? lng) => _lng = lng;

  Cities.fromJson(Map<String, dynamic> json) {
    _value = json['value'];
    _label = json['label'];
    _districtId = json['district_id'];
    _countryId = json['country_id'];
    _provinceId = json['province_id'];
    _regionId = json['region_id'];
    _lat = json['lat'];
    _lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this._value;
    data['label'] = this._label;
    data['district_id'] = this._districtId;
    data['country_id'] = this._countryId;
    data['province_id'] = this._provinceId;
    data['region_id'] = this._regionId;
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    return data;
  }
}

class Probono {
  int? _value;
  String? _label;

  Probono({int? value, String? label}) {
    if (value != null) {
      this._value = value;
    }
    if (label != null) {
      this._label = label;
    }
  }

  int? get value => _value;
  set value(int? value) => _value = value;
  String? get label => _label;
  set label(String? label) => _label = label;

  Probono.fromJson(Map<String, dynamic> json) {
    _value = json['value'];
    _label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this._value;
    data['label'] = this._label;
    return data;
  }
}