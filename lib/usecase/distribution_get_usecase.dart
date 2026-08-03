import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/services/distribution_service.dart';
import '../models/distribution.dart';

class GetDistributionUseCase {
  final DistributionService _apiService;

  GetDistributionUseCase(this._apiService);

  Future<Distribution> call(int id) async {
    try {
      return await _apiService.getDistribution(id);
    } catch (e) {
      throw Exception('Failed to get distribution: $e');
    }
  }
}

final getDistributionUseCaseProvider = Provider<GetDistributionUseCase>((ref) {
  final apiService = ref.watch(distributionApiServiceProvider);
  return GetDistributionUseCase(apiService);
});

final distributionProvider =
    FutureProvider.family<Distribution, int>((ref, id) {
  final useCase = ref.watch(getDistributionUseCaseProvider);
  return useCase.call(id);
});
