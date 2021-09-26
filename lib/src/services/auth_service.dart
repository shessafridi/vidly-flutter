import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vidly/src/models/user.dart';

const _tokenKeyName = 'token';
const _storage = FlutterSecureStorage();
User? currentUser;

Future<void> authenticate(BuildContext context, String token) async {
  if (!validateJwt(token)) throw Future.error("Invalid Token");

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
  onAuthenticated(context);
}

onAuthenticated(BuildContext context) async {
  currentUser = await getLoggedInUser();
  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/home');
}

Future<bool> isAuthenticated() async {
  var token = await getToken();
  print("The Token is: $token");
  if (token == null) return false;
  var isValid = validateJwt(token);
  print("The Token validity is: $isValid");
  if (!isValid) return false;
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
  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/welcome');
}

bool validateJwt(String token) {
  var parsedToken = Jwt.parseJwt(token);
  // var date = Jwt.isExpired(token);

  // print(parsedToken);
  if (parsedToken['iat'] != null) {
    // var expiryDate = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true)
    //     .add(Duration(seconds: parsedToken["iat"]));

    // return !DateTime.now().isAfter(expiryDate);
    return true;
  }
  return false;
}

Future<User?> getLoggedInUser() async {
  var token = await getToken();
  if (token == null) return null;

  var payload = Jwt.parseJwt(token);
  return User.fromMap(payload);
}

Future<String?> getToken() async {
  if (kIsWeb) {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKeyName);
  } else {
    return _storage.read(key: _tokenKeyName);
  }
}
