import 'package:shared_preferences/shared_preferences.dart';

class UserLogin {
  bool? status = false;
  String? token;
  String? message;
  int? id;
  String? nama_user;
  String? email;
  String? password;
  String? role;
  String? addres;

  UserLogin(
      {this.status,
      this.token,
      this.message,
      this.id,
      this.nama_user,
      this.email,
      this.password,
      this.role,
      this.addres});

       Future prefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("status", status!);
    prefs.setString("token", token!);
    prefs.setString("message", message!);
    prefs.setInt("id", id!);
    prefs.setString("nama_user", nama_user!);
    prefs.setString("email", email!);
    // prefs.setString("password", password!);
    prefs.setString("role", role!);
    prefs.setString("addres", addres!);
  }

  Future getUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLogin userLogin = UserLogin(
        status: prefs.getBool("status")!,
        token: prefs.getString("token")!,
        message: prefs.getString("message")!,
        id: prefs.getInt("id")!,
        nama_user: prefs.getString("nama_user")!,
        email: prefs.getString("email")!,
        // password: prefs.getString("password")!,
        role: prefs.getString("role")!,
        addres: prefs.getString("addres")!);
    return userLogin;
  }

}
