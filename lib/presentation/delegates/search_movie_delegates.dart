import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef searchMovieCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegates extends SearchDelegate<Movie?> {
  final searchMovieCallBack searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  void clearStream() {
    debouncedMovies.close();
  }

  SearchMovieDelegates(
      {required this.searchMovies, this.initialMovies = const []})
      : super(
            textInputAction: TextInputAction.done,
            searchFieldLabel: 'Buscar Peliculas');

  void onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        // if (query.isEmpty) {

        //   debouncedMovies.add([]);
        //   return;
        // }
        final movies = await searchMovies(query);
        initialMovies = movies;

        if (!debouncedMovies.isClosed) {
          debouncedMovies.add(movies);
          isLoadingStream.add(false);
        }
      },
    );
  }

  // @override
  // String? get searchFieldLabel => 'Buscar Peliculas';

  Widget _BuildResultsAndSugestions() {
    return StreamBuilder(
      // future: searchMovies(query),
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return _MovieItem(
              movie: movie,
              onMovieSelected: (context, movie) {
                clearStream();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // if (query.isNotEmpty)

      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
                duration: Duration(milliseconds: 1000),
                
                infinite: true,
                child: IconButton(
                    onPressed: () => query = '',
                    icon: const Icon(Icons.refresh)));
          }

          return FadeIn(
              child: IconButton(
                  onPressed: () => query = '', icon: const Icon(Icons.clear)));
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStream();
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _BuildResultsAndSugestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    this.onQueryChanged(query);

    return _BuildResultsAndSugestions();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    clearStream();
    super.dispose();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem(
      {super.key, required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium,
                  ),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_outlined,
                        color: Colors.yellow.shade800,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        HumanFormat.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
