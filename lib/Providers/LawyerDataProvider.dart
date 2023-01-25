import 'package:advolocate_app/Model/adovacate_data_model.dart';
import 'package:flutter/widgets.dart';

class LawyerDataProvider extends ChangeNotifier {
  AdvocateData _data = AdvocateData();

  AdvocateData get data => _data;
  void setData(AdvocateData data) {
    this._data = data;
  }
}
