import 'package:flutter/material.dart';
import 'package:the_movie_app/components/smart_list_view.dart';
import 'package:the_movie_app/widgets/title_text.dart';
import '../data/data.vos/movie_vo.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../view_items/movie_view.dart';

class TitleAndHorizontalMovieListView extends StatelessWidget {
  final Function onTapMovie;
  final List<MovieVO>? nowPlayingMovies;
  final String title;
  final Function onListEndReached;

  const TitleAndHorizontalMovieListView(
      {super.key,
      required this.onTapMovie,
      required this.nowPlayingMovies,
      required this.title,
      required this.onListEndReached});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(title),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        HorizontalMovieListView(
          onTapMovie: (movieId) => onTapMovie(movieId),
          movieList: nowPlayingMovies,
          onListEndReached: onListEndReached,
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;
  final Function onListEndReached;

  const HorizontalMovieListView(
      {super.key,
      required this.onTapMovie,
      required this.movieList,
      required this.onListEndReached});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          // ? ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          //     itemCount: movieList?.length ?? 0,
          //     itemBuilder: (BuildContext context, int index) {
          //       return GestureDetector(
          //         onTap: () => onTapMovie(movieList?[index].id),
          //         child: MovieView(
          //           movie: movieList?[index],
          //         ),
          //       );
          //     })

          ? SmartHorizontalListView(
              itemCount: movieList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => onTapMovie(movieList?[index].id),
                  child: MovieView(
                    movie: movieList?[index],
                    onTapMovie: () {
                      onTapMovie(movieList?[index].id);
                    },
                  ),
                );
              },
              onListEndReached: () => onListEndReached(),
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
