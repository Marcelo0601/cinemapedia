import 'package:cinemapedia/domain/datasources/local_storage_database.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repositories.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatabase datasource;

  LocalStorageRepositoryImpl({required this.datasource});

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}
