import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/services/distribution_service.dart';
import '../models/distribution.dart';

class GetDistributionUseCase {
  final DistributionService _apiservice;

  GetDistributionUseCase(this._apiservice);

  Future<Distribution> call(int id) async {
    try {
      return await _apiservice.getDistribution(id);
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
