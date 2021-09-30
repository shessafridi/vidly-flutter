import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vidly/src/config/config.dart';
import 'package:vidly/src/models/errors/bad_request_error.dart';
import 'package:vidly/src/models/errors/invalid_credentials_error.dart';
import 'package:vidly/src/models/user.dart';

final authApiProvider = Provider((ref) => AuthApi());

class AuthApi {
  final _authEndpoint = '/auth';
  final _usersEndpoint = '/users';
  final _headers = {'Content-Type': 'application/json'};

  Future<String> login(String email, String password) async {
    var body = {'email': email, 'password': password};
    var response = await http.post(Uri.parse(apiUrl + _authEndpoint),
        body: jsonEncode(body), headers: _headers);
    if (response.statusCode == 400) {
      throw InvalidCredentialsError();
    }
    if (response.statusCode != 200) return Future.error(response);
    return response.body;
  }

  Future<User> register(String email, String name, String password) async {
    var body = {'email': email, 'name': name, 'password': password};
    var response = await http.post(Uri.parse(apiUrl + _usersEndpoint),
        body: jsonEncode(body), headers: _headers);
    if (response.statusCode == 400) {
      throw BadRequestError(errorMessage: response.body);
    }
    if (response.statusCode != 200) return Future.error(response);
    return User.fromJson(response.body);
  }
}
