import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vidly/src/config/config.dart';
import 'package:vidly/src/models/movie.dart';
import 'package:vidly/src/services/auth_service.dart';

final movieApiProvider = Provider((ref) {
  final authService = ref.watch(authServiceProvider);
  return MoviesApi(authService);
});

final movieListProvider = FutureProvider((ref) async {
  final movieApi = ref.watch(movieApiProvider);
  return await movieApi.getMovies();
});

class MoviesApi {
  AuthService auth;

  MoviesApi(this.auth);

  final _endpoint = '/movies';
  final _headers = {'Content-Type': 'application/json'};

  Future<List<Movie>> getMovies() async {
    var response =
        await http.get(Uri.parse(apiUrl + _endpoint), headers: _headers);
    if (response.statusCode != 200) return Future.error(response);

    List<dynamic> list = jsonDecode(response.body);

    var moviesList = list.map((e) => Movie.fromMap(e)).toList();

    return moviesList;
  }

  Future<Map<String, String>> _getTokenHeader() async {
    var token = auth.token;

    var authHeaders = {'Authentication': "Bearer $token"};
    authHeaders.addAll(_headers);

    return authHeaders;
  }

  Future<Movie> getMovie(String id) async {
    var headers = await _getTokenHeader();

    var response = await http.get(Uri.parse(apiUrl + _endpoint + '/$id'),
        headers: headers);
    if (response.statusCode != 200) return Future.error(response);

    return Movie.fromJson(response.body);
  }

  deleteMovie(String id) async {
    var headers = await _getTokenHeader();

    var response = await http.delete(Uri.parse(apiUrl + _endpoint + '/$id'),
        headers: headers);
    if (response.statusCode != 200) return Future.error(response);

    return Movie.fromJson(response.body);
  }

  updateMovie(Movie movie) async {
    var headers = await _getTokenHeader();

    var response = await http
        .put(Uri.parse(apiUrl + _endpoint + '/${movie.id}'), headers: headers);
    if (response.statusCode != 200) return Future.error(response);

    return Movie.fromJson(response.body);
  }
}
