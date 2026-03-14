import 'package:cinemapedia/presentation/providers/movies/movie_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>(
  (ref) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
    final nowPopular = ref.watch(nowPopularProvider).isEmpty;
    final nowTopRated = ref.watch(nowTopRatedProvider).isEmpty;
    final nowUpcomig = ref.watch(nowUpcomigProvider).isEmpty;
    
    return nowPlayingMovies || nowPopular || nowTopRated || nowUpcomig;
  },
);
