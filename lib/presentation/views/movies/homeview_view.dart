import 'package:cinemapedia/presentation/providers/movies/initial_loading_provider.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(nowPopularProvider.notifier).loadNextPage();
    ref.read(nowTopRatedProvider.notifier).loadNextPage();
    ref.read(nowUpcomigProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final bool initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final nowPopular = ref.watch(nowPopularProvider);
    final nowTopRated = ref.watch(nowTopRatedProvider);
    final nowUpcomig = ref.watch(nowUpcomigProvider);

    final slideShowMovies = ref.watch(movieSlideshowProvider);
    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            flexibleSpace: CustomAppbar(),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Column(
                children: [
                  MoviesSlideshow(movies: slideShowMovies),
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: "Now Playing",
                    subtitle: "Monday 20 ",
                    loadNextPage: () {
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: nowPopular,
                    title: "Popular",
                    subtitle: "This month",
                    loadNextPage: () {
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: nowTopRated,
                    title: "Top Rated",
                    // subtitle: "Desde Siempre",
                    loadNextPage: () {
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: nowUpcomig,
                    title: "Upcoming",
                    subtitle: "Soon",
                    loadNextPage: () {
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            },
          ))
        ],
      ),
    );
  }
}
