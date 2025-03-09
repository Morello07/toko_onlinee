import 'package:flutter/material.dart';
import 'package:movie_flutter/models/user_login.dart';

class BottomNav extends StatefulWidget {
  final int activePage;
  const BottomNav(this.activePage, {super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  UserLogin userLogin = UserLogin();
  String? role;

  getDataLogin() async {
    var user = await userLogin.getUserLogin();
    if (user!.status != false) {
      setState(() {
        role = user.role;
      });
    } else {
      Navigator.popAndPushNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataLogin();
  }

  void getLink(index) {
    if (role == "admin") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/movie');
      }
    } else if (role == "user") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/pesan');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return role != null
        ? BottomNavigationBar(
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey[400],
            currentIndex: widget.activePage,
            elevation: 10, // Tambahkan shadow efek
            type: BottomNavigationBarType.fixed, // Supaya item tidak berubah ukuran
            onTap: getLink, // Langsung panggil function
            items: role == "admin"
                ? const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard, size: 28), // Ubah icon & size
                      label: 'Dashboard',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.movie, size: 28),
                      label: 'Movie',
                    ),
                  ]
                : const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled, size: 28),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart, size: 28),
                      label: 'Pesan',
                    ),
                  ],
          )
        : const SizedBox(); // Jika role masih null, tampilkan SizedBox kosong agar tidak error
  }
}
