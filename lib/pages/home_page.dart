import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:the_movie_app/data/data.vos/genre_vo.dart';
import 'package:the_movie_app/data/models/movie_model.dart';
import 'package:the_movie_app/data/models/movie_model_impl.dart';
import 'package:the_movie_app/pages/movie_details_page.dart';
import 'package:the_movie_app/resources/colors.dart';
import 'package:the_movie_app/resources/dimens.dart';
import 'package:the_movie_app/view_items/actor_view.dart';
import 'package:the_movie_app/view_items/banner_view.dart';
import 'package:the_movie_app/view_items/movie_view.dart';
import 'package:the_movie_app/view_items/show_case_view.dart';
import 'package:the_movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:the_movie_app/widgets/see_more_text.dart';
import 'package:the_movie_app/widgets/title_text.dart';
import 'package:the_movie_app/widgets/title_text_with_see_more_view.dart';
import '../data/data.vos/actor_vo.dart';
import '../data/data.vos/movie_vo.dart';
import '../resources/strings.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          centerTitle: true,
          title: const Text(
            MAIN_PAGE_APP_BAR_TITLE,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: const Icon(Icons.menu),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: MARGIN_MEDIUM_2),
              child: Icon(Icons.search_rounded),
            ),
          ],
        ),
        body: Container(
          color: HOME_SCREEN_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScopedModelDescendant<MovieModelImpl>(
                  builder: (BuildContext context, Widget? child,
                      MovieModelImpl model) {
                    return BannerSectionView(
                      onTapBanner: (movieId) => _navigateToMoviesDetailsScreen(
                          context, movieId, model),
                      movieList:
                          model.mPopularMoviesList?.take(5).toList() ?? [],
                    );
                  },
                ),
                const SizedBox(height: MARGIN_LARGE),
                ScopedModelDescendant<MovieModelImpl>(
                  builder: (BuildContext context, Widget? child,
                      MovieModelImpl model) {
                    return BestPopularMoviesAndSerialsSectionView(
                        onTapMovie: (movieId) => _navigateToMoviesDetailsScreen(
                            context, movieId, model),
                        nowPlayingMovies: model.mNowPlayingMoviesList);
                  },
                ),
                const SizedBox(height: MARGIN_LARGE),
                const CheckMovieShowTimesSectionView(),
                const SizedBox(height: MARGIN_LARGE),
                ScopedModelDescendant<MovieModelImpl>(
                  builder: (BuildContext context, Widget? child,
                      MovieModelImpl model) {
                    return GenreSectionView(
                      moviesByGenre: model.mMoviesByGenreList,
                      onTapMovie: (movieId) => _navigateToMoviesDetailsScreen(
                          context, movieId, model),
                      genreList: model.mGenresList,
                      onChooseGenres: (genreId) {
                        if (genreId != null) {
                          model.getMoviesByGenre(genreId);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: MARGIN_LARGE),
                ScopedModelDescendant<MovieModelImpl>(
                  builder: (BuildContext context, Widget? child,
                      MovieModelImpl model) {
                    return ShowCasesSection(
                      onTapShowCase: (movieId) =>
                          _navigateToMoviesDetailsScreen(
                              context, movieId, model),
                      topRatedMovies: model.mTopRatedMoviesList,
                    );
                  },
                ),
                const SizedBox(height: MARGIN_LARGE),
                ScopedModelDescendant<MovieModelImpl>(
                  builder: (BuildContext context, Widget? child,
                      MovieModelImpl model) {
                    return ActorsAndCreatorsSectionView(
                        titleText: BEST_ACTORS_TITLES,
                        seeMoreText: BEST_ACTORS_SEE_MORE,
                        actorList: model.mActors);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigateToMoviesDetailsScreen(
      BuildContext context, int? movieId, MovieModelImpl model) {
    model.getMovieDetails(movieId ?? 0);
    model.getMovieDetailsFromDatabase(movieId ?? 0);
    model.getCreditsByMovie(movieId ?? 0);
    if (movieId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MovieDetailsPage(),
        ),
      );
    }
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO>? genreList;
  final List<MovieVO>? moviesByGenre;
  final Function(int?) onTapMovie;
  final Function(int?) onChooseGenres;
  const GenreSectionView(
      {super.key,
      required this.moviesByGenre,
      required this.onTapMovie,
      required this.genreList,
      required this.onChooseGenres});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList?.length ?? 0,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                      ?.map(
                        (genre) => Tab(
                          child: Text(genre.name ?? ""),
                        ),
                      )
                      .toList() ??
                  [],
              onTap: (index) {
                onChooseGenres(genreList?[index].id);
              },
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding:
              const EdgeInsets.only(top: MARGIN_MEDIUM_2, bottom: MARGIN_LARGE),
          child: HorizontalMovieListView(
            onTapMovie: (movieId) => onTapMovie(movieId),
            movieList: moviesByGenre,
          ),
        )
      ],
    );
  }
}

class CheckMovieShowTimesSectionView extends StatelessWidget {
  const CheckMovieShowTimesSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      height: SHOWTIME_SECTION_HEIGHT,
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                MAIN_SCREEN_CHECK_MOVIES_SHOWTIMES,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_HEADING_1X,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
                textColor: PLAY_BUTTON_COLOR,
              )
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          )
        ],
      ),
    );
  }
}

class ShowCasesSection extends StatelessWidget {
  final Function onTapShowCase;
  final List<MovieVO>? topRatedMovies;

  const ShowCasesSection(
      {super.key, required this.onTapShowCase, required this.topRatedMovies});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        child: TitleTextWithSeeMoreView(SHOW_CASES_TITLES, SHOW_CASES_SEE_MORE),
      ),
      const SizedBox(height: MARGIN_MEDIUM_2),
      SizedBox(
        height: SHOW_CASES_HEIGHT,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          children: topRatedMovies
                  ?.map((topRatedMovie) => ShowCaseView(
                      movie: topRatedMovie,
                      onTapShowCase: () => onTapShowCase(topRatedMovie.id)))
                  .toList() ??
              [],
        ),
      ),
    ]);
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function onTapMovie;
  final List<MovieVO>? nowPlayingMovies;

  const BestPopularMoviesAndSerialsSectionView(
      {super.key, required this.onTapMovie, required this.nowPlayingMovies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            child: const TitleText(MAIN_SCREEN_BEST_POPULAR_MOVIE_AND_SERIALS)),
        const SizedBox(height: MARGIN_MEDIUM_2),
        HorizontalMovieListView(
            onTapMovie: (movieId) => onTapMovie(movieId),
            movieList: nowPlayingMovies),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;

  const HorizontalMovieListView(
      {super.key, required this.onTapMovie, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              itemCount: movieList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => onTapMovie(movieList?[index].id),
                  child: MovieView(
                    movie: movieList?[index],
                  ),
                );
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  final Function onTapBanner;
  final List<MovieVO> movieList;

  const BannerSectionView(
      {super.key, required this.onTapBanner, required this.movieList});

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            scrollDirection: Axis.horizontal,
            children: widget.movieList
                    .map(
                      (movie) => BannerView(
                          onTapBanner: () => widget.onTapBanner(movie.id),
                          movie: movie),
                    )
                    .toList() ??
                [],
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount:
              widget.movieList.isNotEmpty ? widget.movieList.length ?? 1 : 1,
          position: _position,
          decorator: const DotsDecorator(
              color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
              activeColor: PLAY_BUTTON_COLOR),
        )
      ],
    );
  }
}
