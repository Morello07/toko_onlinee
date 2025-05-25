import 'package:flutter/material.dart';
import 'package:toko_online/views/login_view.dart';
import 'package:toko_online/views/dashboard.dart';
import 'package:toko_online/views/pesan_view.dart';
import 'package:toko_online/views/produk_view.dart';
import 'package:toko_online/views/register_user_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Online',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RegisterUserView(),
        '/login': (context) => const LoginView(),
        '/dashboard': (context) => const DashboardView(),
        '/pesan': (context) => const PesanView(),
        '/produk': (context) => const ProdukView(),
      },
    );
  }
}
