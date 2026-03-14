import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(favoriteMovieProvider.notifier).loadNextPage(0);
  }

  @override
  Widget build(BuildContext context) {
    final favoritesMovies = ref.watch(favoriteMovieProvider).values.toList();

    if (favoritesMovies.isEmpty) {
      return const Center(child: Text('No hay películas favoritas'));
    }

    return Scaffold(body: MovieMasonry(movies: favoritesMovies));
  }
}
