import 'package:movie_flutter/models/user_login.dart';
import 'package:movie_flutter/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  UserLogin userLogin = UserLogin();
  String? nama_user;
  String? role;
  getUserLogin() async {
    var user = await userLogin.getUserLogin();
    if (user.status != false) {
      setState(() {
        nama_user = user.nama_user;
        role = user.role;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/login');
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(child: Text("Selamat Datang $nama_user role anda $role")),
      bottomNavigationBar: BottomNav(0),
    );
  }
}
