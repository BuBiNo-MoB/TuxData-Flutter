import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distribuzioni'),
        // In futuro qui aggiungeremo un pulsante di logout
      ),
      body: const Center(
        child: Text('Qui verrà visualizzata la lista delle distribuzioni.'),
      ),
    );
  }
}
