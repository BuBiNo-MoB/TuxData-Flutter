import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/pages/auth/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TuxData',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueGrey, brightness: Brightness.dark),
      ),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('TuxData'),
      //   ),
      //   body: const Center(
      //     child: Text('Benvenuto in TuxData!'),
      //   ),
      // ),
      home: const HomePage(),
    );
  }
}
