import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/pages/home_page.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowFrame(const Rect.fromLTWH(100, 100, 360, 720));
    setWindowMinSize(const Size(360, 720));
    setWindowMaxSize(Size.infinite);
  }
  runApp(const ProviderScope(child: TuxData()));
}

class TuxData extends StatelessWidget {
  const TuxData({super.key});

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
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_tuxApp.jpg'),
                  fit: BoxFit.cover)),
          child: child,
        );
      },
    );
  }
}
