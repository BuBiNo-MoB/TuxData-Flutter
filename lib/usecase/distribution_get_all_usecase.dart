import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/models/distribution.dart';
import 'package:tux_data_f/services/distribution_service.dart';

class GetAllDistributionsUseCase {
  final DistributionService _apiService;

  GetAllDistributionsUseCase(this._apiService);

  Future<List<Distribution>> call() async {
    try {
      return await _apiService.getAllDistributions();
    } catch (e) {
      throw Exception('Failed to get distributions: $e');
    }
  }
}

final getAllDistributionsUseCaseProvider =
    Provider<GetAllDistributionsUseCase>((ref) {
  final apiService = ref.watch(distributionApiServiceProvider);
  return GetAllDistributionsUseCase(apiService);
});

final distributionsProvider = FutureProvider<List<Distribution>>((ref) {
  final useCase = ref.watch(getAllDistributionsUseCaseProvider);
  return useCase.call();
});
