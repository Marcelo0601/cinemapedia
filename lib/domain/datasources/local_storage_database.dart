import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageDatabase {
  Future<void> toggleFavorite(Movie movie);
  Future<bool> isMovieFavorite(int movieId);
  Future<List<Movie>> loadMovies({limit =10, offset=0});
}
