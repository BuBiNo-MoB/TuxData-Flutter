import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/distribution.dart';
import '../usecase/distribution_get_all_usecase.dart';
import '../usecase/search_distributions_usecase.dart';
import 'distribution_detail_page.dart';

final distributionSearchKeywordProvider = StateProvider<String>((ref) => '');

class DistributionPage extends ConsumerStatefulWidget {
  const DistributionPage({super.key});

  @override
  ConsumerState<DistributionPage> createState() => _DistributionPageState();
}

class _DistributionPageState extends ConsumerState<DistributionPage> {
  List<Distribution> _distributions = [];
  bool _isLoading = false;
  String _errorMessage = '';
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _loadDistributions();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadDistributions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final getAllDistributionsUseCase =
          ref.read(getAllDistributionsUseCaseProvider);
      final distributions = await getAllDistributionsUseCase.call();

      setState(() {
        _distributions = distributions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search distributions...',
            border: InputBorder.none,
            icon: Icon(Icons.search),
          ),
          onSubmitted: (value) {
            ref.read(distributionSearchKeywordProvider.notifier).state = value;
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDistributions,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return _buildDistributionsList();
  }

  Widget _buildDistributionsList() {
    final keyword = ref.watch(distributionSearchKeywordProvider);

    if (keyword.trim().isEmpty) {
      return RefreshIndicator(
        onRefresh: _loadDistributions,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: _distributions.length,
          itemBuilder: (context, index) {
            final distribution = _distributions[index];
            return _buildDistributionCard(distribution);
          },
        ),
      );
    }

    final searchResults = ref.watch(searchDistributionProvider(keyword));

    return searchResults.when(
      data: (distributions) {
        if (distributions.isEmpty) {
          return const Center(child: Text('No distributions found'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: distributions.length,
          itemBuilder: (context, index) {
            final distribution = distributions[index];
            return _buildDistributionCard(distribution);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }

  Widget _buildDistributionCard(Distribution distribution) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: _buildDistributionLogo(distribution),
        title: Text(
          distribution.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              distribution.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.desktop_windows,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    distribution.desktopEnvironment,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.favorite,
                  size: 16,
                  color: Colors.red[400],
                ),
                const SizedBox(width: 4),
                Text(
                  '${distribution.likes}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _showDistributionInfo(distribution),
      ),
    );
  }

  Widget _buildDistributionLogo(Distribution distribution) {
    if (distribution.logoUrl != null && distribution.logoUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[200],
        child: ClipOval(
          child: Image.network(
            distribution.logoUrl!,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.computer,
                size: 24,
                color: Colors.grey,
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            },
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.blue[100],
      child: const Icon(
        Icons.computer,
        size: 24,
        color: Colors.blue,
      ),
    );
  }

  //COMMENTATO PERCHè C'è UNA PAGINA ADESSO,
  // void _showDistributionInfo(Distribution distribution) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(distribution.name),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               if (distribution.logoUrl != null)
  //                 Center(
  //                   child: Image.network(
  //                     distribution.logoUrl!,
  //                     height: 80,
  //                     errorBuilder: (_, __, ___) => const Icon(
  //                       Icons.computer,
  //                       size: 80,
  //                     ),
  //                   ),
  //                 ),
  //               const SizedBox(height: 16),
  //               _buildInfoRow('Version', distribution.currentVersion),
  //               _buildInfoRow(
  //                   'Desktop Environment', distribution.desktopEnvironment),
  //               _buildInfoRow('Base Distribution', distribution.baseDistro),
  //               _buildInfoRow('Package Type', distribution.packageType),
  //               _buildInfoRow(
  //                   'Architecture', distribution.supportedArchitecture),
  //               _buildInfoRow('Likes', distribution.likes.toString()),
  //               const SizedBox(height: 12),
  //               Text(
  //                 'Description:',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.grey[700],
  //                 ),
  //               ),
  //               const SizedBox(height: 4),
  //               Text(distribution.description),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Widget _buildInfoRow(String label, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 2),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           width: 80,
  //           child: Text(
  //             '$label:',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: 12,
  //               color: Colors.grey[700],
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: Text(
  //             value.isNotEmpty ? value : 'N/A',
  //             style: const TextStyle(fontSize: 12),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showDistributionInfo(Distribution distribution) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DistributionDetailPage(distribution: distribution),
      ),
    );
  }
}
