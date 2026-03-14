import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repositories.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMovieProvider =
    StateNotifierProvider<StorageFavoriteNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageProvider);
  return StorageFavoriteNotifier(localStorageRepository: localStorageRepository);
});

class StorageFavoriteNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageFavoriteNotifier({required this.localStorageRepository}) : super({});

  Future<void> loadNextPage(int page) async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10);
    page++;

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }
    state = {...state, ...tempMoviesMap};
    // return movies;
  }
}
