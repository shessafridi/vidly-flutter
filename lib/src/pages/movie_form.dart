import 'package:flutter/material.dart';
import 'package:vidly/src/models/movie.dart';

class MovieFormPage extends StatelessWidget {
  final Movie movie;
  const MovieFormPage({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Hero(
                tag: movie.id,
                child: Material(
                  child: ListTile(
                    leading: const Icon(Icons.movie),
                    title: Text(movie.title),
                    subtitle: Text(movie.genre.name),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
