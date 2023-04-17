import 'package:flutter/material.dart';
import 'package:the_movie_app/bloc/home_bloc.dart';
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
import 'package:provider/provider.dart';

import '../widgets/title_and_horizontal_movie_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeBloc(),
      child: SafeArea(
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
                  Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) => bloc.mPopularMoviesList ?? [],
                    builder: (context, popularMovieList, child) =>
                        BannerSectionView(
                      onTapBanner: (movieId) =>
                          _navigateToMoviesDetailsScreen(context, movieId),
                      movieList: popularMovieList.take(7).toList() ?? [],
                    ),
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) =>
                        bloc.mNowPlayingMoviesList ?? [],
                    builder: (context, nowPlayingMovieList, child) =>
                        TitleAndHorizontalMovieListView(
                            title: MAIN_SCREEN_BEST_POPULAR_MOVIE_AND_SERIALS,
                            onTapMovie: (movieId) =>
                                _navigateToMoviesDetailsScreen(
                                    context, movieId),
                            nowPlayingMovies: nowPlayingMovieList,
                        onListEndReached: () {
                              var bloc = Provider.of<HomeBloc>(context, listen: false);
                              bloc.onNowPlayingMovieListEndReached();
                        },),
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  const CheckMovieShowTimesSectionView(),
                  const SizedBox(height: MARGIN_LARGE),
                  Selector<HomeBloc, List<GenreVO>>(
                    selector: (context, bloc) => bloc.mGenresList ?? [],
                    builder: (context, genreList, child) =>
                        Selector<HomeBloc, List<MovieVO>>(
                      selector: (context, bloc) => bloc.mMoviesByGenre ?? [],
                      builder: (context, moviesByGenreList, child) =>
                          GenreSectionView(
                        moviesByGenre: moviesByGenreList,
                        onTapMovie: (movieId) =>
                            _navigateToMoviesDetailsScreen(context, movieId),
                        genreList: genreList,
                        onChooseGenres: (genreId) {
                          HomeBloc bloc =
                              Provider.of<HomeBloc>(context, listen: false);
                          bloc.onChooseGenres(genreId!);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) => bloc.mTopRatedMoviesList ?? [],
                    builder: (context, topRatedMovieList, child) =>
                        ShowCasesSection(
                      onTapShowCase: (movieId) =>
                          _navigateToMoviesDetailsScreen(context, movieId),
                      topRatedMovies: topRatedMovieList,
                    ),
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  Selector<HomeBloc, List<ActorVO>>(
                    selector: (context, bloc) => bloc.mActorList ?? [],
                    builder: (context, actorList, child) =>
                        ActorsAndCreatorsSectionView(
                            titleText: BEST_ACTORS_TITLES,
                            seeMoreText: BEST_ACTORS_SEE_MORE,
                            actorList: actorList),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _navigateToMoviesDetailsScreen(BuildContext context, int? movieId) {
    if (movieId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsPage(
            movieId: movieId,
          ),
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
            movieList: moviesByGenre, onListEndReached: (){},
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
