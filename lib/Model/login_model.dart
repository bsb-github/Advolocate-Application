import 'dart:convert';
import 'package:http/http.dart' as http;

Future LoginUser(
  String email,
  String password,
) async {
  String url = 'http://www.advolocate.info/api/login';
  final response = await http.post(Uri.parse(url), body: {
    'email': email,
    'password': password,
  });
  var convertedDataJson = jsonDecode(response.body);
  print(convertedDataJson);
  return convertedDataJson;
}
