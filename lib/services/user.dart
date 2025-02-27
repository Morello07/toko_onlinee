import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/response_data_map.dart';
import '../models/user_login.dart';
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
    var uri = Uri.parse("$Base_Url/register_admin"); // Pakai BaseUrl dari url.dart
    var response = await http.post(uri, body: data);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == true) {
        UserLogin userLogin = UserLogin(
          status: data["status"],
          token: data["token"],
          message: data["message"],
          id: data["user"]["id"],
          nama_user: data["user"]["nama_user"],
          email: data["user"]["email"],
          role: data["user"]["role"],
        );
        await userLogin.prefs();
        return ResponseDataMap(status: true, message: "Sukses login user", data: data);
      } else {
        return ResponseDataMap(status: false, message: 'Email dan password salah');
      }
    } else {
      return ResponseDataMap(status: false, message: "Gagal login user dengan code error ${response.statusCode}");
    }
  }
}
