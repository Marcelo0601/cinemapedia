import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ActorByMovieProvider =
    StateNotifierProvider<ActorsByMovieProvider, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieProvider(getActors: actorsRepository.getActorByMovie);
});

typedef GetActorsCallBack = Future<List<Actor>> Function(String movie);

class ActorsByMovieProvider extends StateNotifier<Map<String,List <Actor>>> {
  GetActorsCallBack getActors;
  ActorsByMovieProvider({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
