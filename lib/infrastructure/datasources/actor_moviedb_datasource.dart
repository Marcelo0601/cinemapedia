import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actor_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mapper/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        "language": "es-MX"
      }));
  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    try {
      final response = await dio.get('/movie/$movieId/credits');
      if (response.statusCode != 200) {
        throw Exception('Error al obtener los actores: ${response.statusCode}');
      }
      final castResponse = CreditsResponse.fromJson(response.data);
      List<Actor> actors = castResponse.cast
          .map((cast) => ActorMapper.castToEntity(cast))
          .toList();
      return actors;
    } catch (e) {
      throw Exception('Error al procesar los actores: $e');
    }
  }
}
