import 'dart:convert';
import 'package:http/http.dart' as http;

Future signupUser(
  String email,
  String password,
) async {
  String url = 'http://www.advolocate.info/api/register_customer';
  final response = await http.post(Uri.parse(url), body: {
    'email': email,
    'password': password,
  });
  var convertedDataJson = jsonDecode(response.body);
  print("Rgister Data" + response.body);
  return convertedDataJson;
}
