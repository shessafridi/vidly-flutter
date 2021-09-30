import 'dart:convert';

import 'genre.dart';

class Movie {
  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.numberInStock,
    required this.dailyRentalRate,
  });

  String id;
  String title;
  Genre genre;
  int numberInStock;
  num dailyRentalRate;

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        id: json["_id"],
        title: json["title"],
        genre: Genre.fromMap(json["genre"]),
        numberInStock: json["numberInStock"],
        dailyRentalRate: json["dailyRentalRate"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "genre": genre.toMap(),
        "numberInStock": numberInStock,
        "dailyRentalRate": dailyRentalRate,
      };
}
