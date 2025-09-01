import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/services/auth_api_service.dart';

class LoginUsecase {
  final AuthApiService _apiService;

  LoginUsecase(this._apiService);

  Future<String> call(String username, String password) {
    return _apiService.login(username, password);
  }
}

final loginUsecaseProvider = Provider<LoginUsecase>((ref) {
  final apiService = ref.watch((authApiServiceProvider));
  return LoginUsecase(apiService);
});
