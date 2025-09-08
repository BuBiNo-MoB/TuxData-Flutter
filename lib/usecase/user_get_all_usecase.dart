import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/services/user_service.dart';
import '../models/user.dart';

class GetAllUsersUseCase {
  final UserService _apiservice;

  GetAllUsersUseCase(this._apiservice);

  Future<List<User>> call() async {
    try {
      return await _apiservice.getAllUsers();
    } catch (e) {
      throw Exception('Failed to get users: $e');
    }
  }
}

final getAllUsersUseCaseProvider = Provider<GetAllUsersUseCase>((ref) {
  final apiService = ref.watch(userApiServiceProvider);
  return GetAllUsersUseCase(apiService);
});

final usersProvider = FutureProvider<List<User>>((ref) {
  final useCase = ref.watch(getAllUsersUseCaseProvider);
  return useCase.call();
});
