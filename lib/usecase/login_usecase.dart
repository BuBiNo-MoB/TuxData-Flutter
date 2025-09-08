import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/services/auth_api_service.dart';

import 'current_user_get_usecase.dart';

class LoginUseCase {
  final AuthApiService _apiService;
  final TokenStorage _tokenStorage;

  LoginUseCase(this._apiService, this._tokenStorage);

  Future<String> call(String username, String password, WidgetRef ref) async {
    final token = await _apiService.login(username, password);
    await _tokenStorage.saveToken(token);
    ref.invalidate(authTokenProvider);
    ref.invalidate(currentUserProvider);

    return token;
  }
}

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final apiService = ref.watch((authApiServiceProvider));
  final tokenStorage = ref.watch(tokenStorageProvider);
  return LoginUseCase(apiService, tokenStorage);
});

final authTokenProvider = FutureProvider<String?>((ref) async {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return await tokenStorage.getToken();
});
