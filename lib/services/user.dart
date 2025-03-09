import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/response_data_map.dart';
import './url.dart'; // Import URL

class UserService {
  Future registerUser(data) async {
    var uri = Uri.parse("$Base_Url/register_admin"); // Pakai BaseUrl dari url.dart
    var response = await http.post(uri, body: data);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == true) {
        return ResponseDataMap(status: true, message: "Sukses menambah user", data: data);
      } else {
        var message = data["message"].values.join('\n');
        return ResponseDataMap(status: false, message: message);
      }
    } else {
      return ResponseDataMap(status: false, message: "Gagal menambah user dengan code error ${response.statusCode}");
    }
  }

  Future loginUser(data) async {
  var uri = Uri.parse("$Base_Url/login_user"); // Pakai BaseUrl dari url.dart
  var response = await http.post(uri, body: data);

  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);
    if (responseData["status"] == true) {
      return ResponseDataMap(status: true, message: "Sukses login user", data: responseData);
    } else {
      return ResponseDataMap(status: false, message: responseData["Gagal login user"]);
    }
  } else {
    return ResponseDataMap(status: false, message: "Gagal login dengan code error ${response.statusCode}");
  }
}

}
