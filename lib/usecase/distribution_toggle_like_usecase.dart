import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/services/distribution_service.dart';

class DistributionToggleLikeUseCase {
  final DistributionService _apiService;

  DistributionToggleLikeUseCase(this._apiService);

  Future<void> call(int id, {required bool currentlyLiked}) async {
    try {
      if (currentlyLiked) {
        await _apiService.removeLikeFromDistribution(id);
      } else {
        await _apiService.addLikeToDistribution(id);
      }
    } catch (e) {
      throw Exception('Failed to toggle like: $e');
    }
  }
}

final distributionToggleLikeUseCaseProvider =
    Provider<DistributionToggleLikeUseCase>((ref) {
  final apiService = ref.watch(distributionApiServiceProvider);
  return DistributionToggleLikeUseCase(apiService);
});
