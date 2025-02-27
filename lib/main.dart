import 'package:flutter/material.dart';
import 'package:movie_flutter/views/dashboard.dart';
import 'package:movie_flutter/views/login_view.dart';
import 'package:movie_flutter/views/movie_view.dart';
import 'package:movie_flutter/views/pesan_view.dart';
import 'package:movie_flutter/views/register_user_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Online',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const RegisterUserView(),
        '/login': (context) => const LoginView(),
        '/dashboard': (context) => const DashboardView(),
        '/movie': (context) => const MovieView(),
        '/pesan': (context) => const PesanView(),
      },
    );
  }
}
