import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/services/auth_api_service.dart';

class RegisterUsecase {
  final AuthApiService _apiService;

  RegisterUsecase(this._apiService);

  Future<void> call(String firstName, String lastName, String username,
      String email, String password, File? avatar) {
    return _apiService.register(
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: email,
        password: password,
        avatar: avatar);
  }
}

final registerUsecaseProvider = Provider<RegisterUsecase>((ref) {
  final apiService = ref.watch((authApiServiceProvider));
  return RegisterUsecase(apiService);
});
