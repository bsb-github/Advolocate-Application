import 'package:flutter/material.dart';

class ImageUrlProvider extends ChangeNotifier {
  String _imageUrl =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  String get imageUrl => _imageUrl;

  void setImageURl(String imageURl) {
    this._imageUrl = imageURl;
    notifyListeners();
  }
}
