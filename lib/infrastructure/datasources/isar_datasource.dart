import 'package:cinemapedia/domain/datasources/local_storage_database.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatabase {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
    final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([MovieSchema], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final Isar = await db;
    final Movie? isMovieFavorite =
        await Isar.movies.filter().idEqualTo(movieId).findFirst();
    return isMovieFavorite != null;
  }

  @override
  Future<List<Movie>> loadMovies({limit = 10, offset = 0}) async {
    final Isar = await db;

    return Isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final Isar = await db;

    final favoriteMovie =
        await Isar.movies.filter().idEqualTo(movie.id).findFirst();
    if (favoriteMovie != null) return Isar.writeTxnSync(() => Isar.movies.deleteSync(movie.id),);

    return Isar.writeTxnSync(() => Isar.movies.putSync(movie));
  }
}
