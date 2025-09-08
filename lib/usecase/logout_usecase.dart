import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/services/auth_api_service.dart';

import 'current_user_get_usecase.dart';
import 'login_usecase.dart';

class LogoutUseCase {
  final TokenStorage _tokenStorage;

  LogoutUseCase(this._tokenStorage);

  Future<void> call(WidgetRef ref) async {
    await _tokenStorage.deleteToken();
    ref.invalidate(authTokenProvider);
    ref.invalidate(currentUserProvider);
  }
}

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return LogoutUseCase(tokenStorage);
});
