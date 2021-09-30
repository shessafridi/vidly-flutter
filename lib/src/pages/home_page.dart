import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidly/src/api/movies.dart';
import 'package:vidly/src/services/auth_service.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final auth = watch(authServiceProvider);
    final movies = watch(movieListProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Vidly"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  auth.logout(context);
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        body: movies.when(
            data: (movies) => ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = movies[index];

                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.movie),
                        title: Text(movie.title),
                        subtitle: Text(movie.genre.name),
                      ),
                    );
                  },
                  itemCount: movies.length,
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stackTrace) => const Text("Aw shit.")));
  }
}
