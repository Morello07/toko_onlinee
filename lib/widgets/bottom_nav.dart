import 'package:flutter/material.dart';
import 'package:toko_online/models/user_login.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;
  const BottomNav(this.currentIndex, {Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  String userRole = '';

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  void getUserRole() async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();
    if (mounted) {
      setState(() {
        userRole = user.role ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userRole == 'kasir') {
      return BottomNavigationBar(
        currentIndex: widget.currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Produk',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/produk');
          }
        },
      );
    } else if (userRole == 'pelanggan') {
      return BottomNavigationBar(
        currentIndex: widget.currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pesan',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/pesan');
          }
        },
      );
    }

    // Default empty bottom navigation bar if role is neither kasir nor pelanggan
    return const SizedBox.shrink();
  }
}
