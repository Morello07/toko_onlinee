import 'dart:convert';
import 'package:toko_online/models/user_login.dart';
import 'package:toko_online/models/user_login.dart';
import '../models/response_data_map.dart';
import 'url.dart' as url;
import 'package:http/http.dart' as http;

class UserService {
  Future registerUser(data) async {
    var uri = Uri.parse(url.Base_Url + "/register_admin");
    var register = await http.post(uri, body: data);

    if (register.statusCode == 200) {
      var data = json.decode(register.body);
      if (data["status"] == true) {
        ResponseDataMap response = ResponseDataMap(
            status: true, message: "Sukses menambah user", data: data);
        return response;
      } else {
        var message = '';
        for (String key in data["message"].keys) {
          message += data["message"][key][0].toString() + '\n';
        }
        ResponseDataMap response =
            ResponseDataMap(status: false, message: message);
        return response;
      }
    } else {
      ResponseDataMap response = ResponseDataMap(
          status: false,
          message:
              "Gagal menambahkan user dengan code error ${register.statusCode}");
      return response;
    }
  }


Future loginUser(data) async {
  var uri = Uri.parse(url.Base_Url + "/login_user");
  var register = await http.post(uri, body: data);
  
  if (register.statusCode == 200) {
    var data = json.decode(register.body);
    print(data["status"]);
    if (data["status"] == true) {
      UserLogin userLogin = UserLogin(
        status: data["status"],
        token: data["token"],
        message: data["message"],
        id: data["data"]["id"],
        nama_user: data["data"]["name"],
        email: data["data"]["email"],
        // password: data["data"]["password"],
        addres: data["data"]["addres"],
        role: data["data"]["role"],
      );

      await userLogin.prefs();
      ResponseDataMap response = ResponseDataMap(
          status: true, message: "Sukses login user", data: data);
      return response;
    } else {
      ResponseDataMap response =
          ResponseDataMap(status: false, message: "Email dan Password salah");
      return response;
    }
  } else {
    ResponseDataMap response = ResponseDataMap(
        status: false,
        message:
            "gagal menambah user dengan code error ${register.statusCode}");
    return response;
  }
}
}