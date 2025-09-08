import 'package:flutter/material.dart';
import 'package:tux_data_f/models/distribution.dart';

class DistributionDetailPage extends StatelessWidget {
  final Distribution distribution;

  const DistributionDetailPage({super.key, required this.distribution});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(distribution.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (distribution.logoUrl != null &&
                distribution.logoUrl!.isNotEmpty)
              Center(
                child: Image.network(
                  distribution.logoUrl!,
                  height: 100,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.computer, size: 100),
                ),
              ),
            const SizedBox(height: 16),
            _buildInfoRow('Version', distribution.currentVersion),
            _buildInfoRow(
                'Desktop Environment', distribution.desktopEnvironment),
            _buildInfoRow('Base Distribution', distribution.baseDistro),
            _buildInfoRow('Package Type', distribution.packageType),
            _buildInfoRow('Architecture', distribution.supportedArchitecture),
            _buildInfoRow('Likes', distribution.likes.toString()),
            const SizedBox(height: 12),
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(distribution.description),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value.isNotEmpty ? value : 'N/A')),
        ],
      ),
    );
  }
}
