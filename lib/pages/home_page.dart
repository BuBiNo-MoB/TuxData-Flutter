import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/components/distro_logo_carousel.dart';
import 'package:tux_data_f/pages/distributions_page.dart';
import '../components/menu_drawer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Tux Data'),
        backgroundColor: Colors.blueGrey.withOpacity(0.2),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const DistroLogoCarousel(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DistributionPage()),
                );
              },
              child: const Text('Explore Distributions'),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'Explore, compare, and discover the best Linux distributions with ',
                      ),
                      TextSpan(
                        text: 'Tuxdata',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text:
                            '. Whether you are a beginner or an expert, here you will find all the information you need to choose the perfect distro for you.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const MainMenuDrawer(),
    );
  }
}
