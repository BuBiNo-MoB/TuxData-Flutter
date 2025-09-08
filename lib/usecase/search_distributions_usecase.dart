import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/models/distribution.dart';
import 'package:tux_data_f/services/distribution_service.dart';

class SearchDistributionsUseCase {
  final DistributionService _apiService;

  SearchDistributionsUseCase(this._apiService);

  Future<List<Distribution>> call(String keyword) async {
    if (keyword.trim().isEmpty) {
      throw Exception('Search keyword cannot be empty');
    }

    try {
      return await _apiService.searchDistributions(keyword);
    } catch (e) {
      throw Exception('Failed to search distributions: $e');
    }
  }
}

final searchDistributionsUseCaseProvider =
    Provider<SearchDistributionsUseCase>((ref) {
  final apiService = ref.watch(distributionApiServiceProvider);
  return SearchDistributionsUseCase(apiService);
});

final searchDistributionProvider =
    FutureProvider.family<List<Distribution>, String>((ref, keyword) {
  final useCase = ref.watch(searchDistributionsUseCaseProvider);
  return useCase.call(keyword);
});
