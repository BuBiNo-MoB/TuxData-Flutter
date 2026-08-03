import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/services/auth_api_service.dart';

class AuthenticatedClient extends http.BaseClient {
  final http.Client _inner;
  final TokenStorage _tokenStorage;

  AuthenticatedClient(this._inner, this._tokenStorage);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = await _tokenStorage.getToken();
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    return _inner.send(request);
  }
}

final authenticatedClientProvider = Provider<http.Client>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return AuthenticatedClient(http.Client(), tokenStorage);
});
