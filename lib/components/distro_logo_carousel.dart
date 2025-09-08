import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/usecase/distribution_get_all_usecase.dart';

class DistroLogoCarousel extends ConsumerWidget {
  const DistroLogoCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDistributions = ref.watch(distributionsProvider);

    return asyncDistributions.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Errore: $err')),
      data: (distributions) {
        final itemsWithLogos =
            distributions.where((d) => d.logoUrl!.isNotEmpty).toList();

        return CarouselSlider.builder(
          itemCount: itemsWithLogos.length,
          itemBuilder: (context, index, realIndex) {
            final distribution = itemsWithLogos[index];
            // return Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 5.0),
            //   child: Image.network(
            //     distribution.logoUrl ?? '',
            //     fit: BoxFit.contain,
            //     errorBuilder: (context, error, stackTrace) {
            //       return const Icon(Icons.error, color: Colors.red);
            //     },
            //   ),
            // );
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Image.network(
                  distribution.logoUrl!,
                )),
                const SizedBox(height: 10),
                Text(
                  distribution.name,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            );
          },
          options: CarouselOptions(
            height: 130.0,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction:
                0.4, // Quanta parte degli elementi adiacenti mostrare
          ),
        );
      },
    );
  }
}
