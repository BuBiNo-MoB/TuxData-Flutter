import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/models/distribution.dart';
import 'package:tux_data_f/services/distribution_service.dart';

class DistributionGetByDeUseCase {
  final DistributionService _apiService;

  DistributionGetByDeUseCase(this._apiService);

  Future<List<Distribution>> call(String desktopEnvironment) async {
    try {
      return await _apiService.searchDistributions(desktopEnvironment);
    } catch (e) {
      throw Exception('Failed to find distributions: $e');
    }
  }
}

final distributionGetByDeUseCaseProvider =
    Provider<DistributionGetByDeUseCase>((ref) {
  final apiService = ref.watch(distributionApiServiceProvider);
  return DistributionGetByDeUseCase(apiService);
});

final distributionGetByDeProvider =
    FutureProvider.family<List<Distribution>, String>(
        (ref, desktopEnvironment) {
  final useCase = ref.watch(distributionGetByDeUseCaseProvider);
  return useCase.call(desktopEnvironment);
});
