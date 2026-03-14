import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatelessWidget {
  const MovieMasonry({super.key, required this.movies, this.loadNextPage});
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
              SizedBox(height: 30,),
            MoviePosterLink(movie: movies[index]),
              ],
            );
          }
          return MoviePosterLink(movie: movies[index]);
        },
      ),
    );
  }
}
