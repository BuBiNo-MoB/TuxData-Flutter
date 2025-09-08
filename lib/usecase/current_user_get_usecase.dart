import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/services/user_service.dart';

import '../models/user.dart';
import 'login_usecase.dart';

class CurrentUserGetUseCase {
  final UserService _apiService;

  CurrentUserGetUseCase(this._apiService);

  Future<User> call(String token) async {
    try {
      return await _apiService.getCurrentUser(token);
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }
}

final getCurrentUserUseCaseProvider = Provider<CurrentUserGetUseCase>((ref) {
  final apiService = ref.watch(userApiServiceProvider);
  return CurrentUserGetUseCase(apiService);
});

final currentUserProvider = FutureProvider<User?>((ref) async {
  final useCase = ref.watch(getCurrentUserUseCaseProvider);
  try {
    final token = await ref.watch(authTokenProvider.future);
    if (token == null || token.isEmpty) {
      return null;
    }
    return await useCase.call(token);
  } catch (e) {
    return null;
  }
});
