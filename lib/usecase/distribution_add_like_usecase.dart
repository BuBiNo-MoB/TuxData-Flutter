import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/services/distribution_service.dart';

class DistributionAddLikeUseCase {
  final DistributionService _apiService;

  DistributionAddLikeUseCase(this._apiService);

  Future<void> call(int id) async {
    try {
      await _apiService.addLikeToDistribution(id);
    } catch (e) {
      throw Exception('Failed to add like: $e');
    }
  }
}

final distributionAddLikeUseCaseProvider =
    Provider<DistributionAddLikeUseCase>((ref) {
  final apiService = ref.watch(distributionApiServiceProvider);
  return DistributionAddLikeUseCase(apiService);
});
