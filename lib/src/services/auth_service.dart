import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vidly/src/api/auth.dart';
import 'package:vidly/src/models/errors/bad_request_error.dart';
import 'package:vidly/src/models/errors/invalid_credentials_error.dart';
import 'package:vidly/src/models/errors/unautorized_error.dart';
import 'package:vidly/src/models/user.dart';
import 'package:vidly/src/services/navigation_service.dart';

final authServiceProvider = ChangeNotifierProvider((ref) {
  return AuthService(ref);
});

const _tokenKeyName = 'token';
const _storage = FlutterSecureStorage();

class AuthService with ChangeNotifier {
  final ProviderReference ref;
  final AuthApi auth;
  final NavigationService router;

  bool isLoading = false;
  String? errorMessage;
  String? token;
  bool isAuthenticated = false;
  User? currentUser;

  AuthService(this.ref)
      : auth = ref.read(authApiProvider),
        router = ref.read(navigationServiceProvider);

  Future<bool> checkAuth() async {
    currentUser = await getLoggedInUser();
    notifyListeners();
    if (currentUser == null) return false;
    return true;
  }

  logout(BuildContext context) async {
    if (kIsWeb) {
      var prefs = await SharedPreferences.getInstance();
      prefs.remove(_tokenKeyName);
    } else {
      var hasKey = await _storage.containsKey(key: _tokenKeyName);
      if (hasKey) {
        _storage.delete(key: _tokenKeyName);
      }
    }
    router.fullyReplacyBy('/welcome');
  }

  Future<void> signUp(String email, String name, String password) async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      await auth.register(email, name, password);
    } on BadRequestError catch (e) {
      errorMessage = e.toString();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();
    try {
      var token = await auth.login(email, password);

      if (kIsWeb) {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString(_tokenKeyName, token);
      } else {
        var hasKey = await _storage.containsKey(key: _tokenKeyName);
        if (hasKey) {
          _storage.delete(key: _tokenKeyName);
        }

        _storage.write(key: _tokenKeyName, value: token);
      }
    } on InvalidCredentialsError {
      errorMessage = 'Invalid email or password.';
    } catch (e) {
      errorMessage = 'An unknown error occured.';
    } finally {
      isLoading = false;
      currentUser = await getLoggedInUser();
      notifyListeners();
    }
  }

  bool validateJwt(String token) {
    var parsedToken = Jwt.parseJwt(token);
    if (parsedToken['iat'] != null) {
      return true;
    }
    return false;
  }

  Future<User?> getLoggedInUser() async {
    try {
      var token = await getToken();
      this.token = token;
      var payload = Jwt.parseJwt(token);
      return User.fromMap(payload);
    } on UnauthorizedError {
      return null;
    }
  }

  Future<String> getToken() async {
    String? token;
    if (kIsWeb) {
      var prefs = await SharedPreferences.getInstance();
      token = prefs.getString(_tokenKeyName);
    } else {
      token = await _storage.read(key: _tokenKeyName);
    }
    if (token == null) throw UnauthorizedError();
    return token;
  }
}
