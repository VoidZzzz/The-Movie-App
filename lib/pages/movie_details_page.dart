import 'package:flutter/material.dart';
import 'package:the_movie_app/blocs/movie_details_bloc.dart';
import 'package:the_movie_app/data/models/movie_model_impl.dart';
import 'package:the_movie_app/network/api_constants.dart';
import 'package:the_movie_app/resources/colors.dart';
import 'package:the_movie_app/resources/dimens.dart';
import 'package:the_movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:the_movie_app/widgets/gradient_view.dart';
import 'package:the_movie_app/widgets/rating_view.dart';
import 'package:the_movie_app/widgets/title_text.dart';
import 'package:the_movie_app/resources/strings.dart';

import '../data/data.vos/actor_vo.dart';
import '../data/data.vos/movie_vo.dart';
import '../data/models/movie_model.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late MovieDetailsBloc _bloc;

  @override
  void initState() {
    _bloc = MovieDetailsBloc(widget.movieId);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.disposeStreams();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.movieStreamController.stream.asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<MovieVO> snapshot) {
          return Container(
            color: HOME_SCREEN_BACKGROUND_COLOR,
            child: CustomScrollView(
              slivers: [
                MovieDetailsSliverAppBarView(
                  onTapBack: () => Navigator.pop(context),
                  movie: snapshot.data,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM_2),
                        child: TrailerSection(
                          storyLine: snapshot.data?.overview ?? "",
                          genreList:
                          snapshot.data?.getGenreListAsStringList() ?? [],
                        ),
                      ),
                      const SizedBox(height: MARGIN_LARGE),
                      StreamBuilder(stream: _bloc.actorsStreamController.stream.asBroadcastStream(),
                          builder: (BuildContext context, AsyncSnapshot<
                              List<ActorVO>> snapshot) {
                            return ActorsAndCreatorsSectionView(
                              titleText: MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
                              seeMoreText: "",
                              actorList: snapshot.data,
                              seeMoreButtonVisibility: false,
                            );
                          },
                          ),
                      const SizedBox(height: MARGIN_LARGE),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM_2),
                        child: AboutFilmSectionView(
                          movieVO: snapshot.data,
                        ),
                      ),
                      const SizedBox(height: MARGIN_LARGE),
                      StreamBuilder(stream: _bloc.creatorsStreamController
                          .stream.asBroadcastStream(),
                        builder: (BuildContext context, AsyncSnapshot<
                            List<ActorVO>> snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            print("Snapshot has data");
                            return ActorsAndCreatorsSectionView(
                                titleText: MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                                seeMoreText: MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
                                actorList: snapshot.data);
                          } else {
                            print("Snapshot does not have data");
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  final MovieVO? movieVO;

  const AboutFilmSectionView({super.key, required this.movieVO});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText("ABOUT FILM"),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Original Title:", movieVO?.title ?? ""),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView(
            "Type:", movieVO?.getGenreListAsCommaSeparatedString() ?? ""),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Production:",
            movieVO?.getProductionCountriesAsCommaSeparatedString() ?? ""),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Premiere:", movieVO?.releaseDate ?? ""),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Description:", movieVO?.overview ?? ""),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String label;
  final String description;

  AboutFilmInfoView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width / 4,
          child: Text(
            label,
            style: const TextStyle(
                color: MOVIE_DETAILS_INFO_TEXT_COLOR,
                fontSize: MARGIN_MEDIUM_2,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: MARGIN_CARD_MEDIUM),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
                color: Colors.white,
                fontSize: MARGIN_MEDIUM_2,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final List<String> genreList;
  final String storyLine;

  const TrailerSection(
      {super.key, required this.storyLine, required this.genreList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        const SizedBox(height: MARGIN_MEDIUM_3),
        StoryLineView(
          storyLine: storyLine,
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: [
            MovieDetailsScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              const Icon(
                Icons.play_circle_fill,
                color: Colors.black54,
              ),
            ),
            const SizedBox(width: MARGIN_CARD_MEDIUM),
            MovieDetailsScreenButtonView(
              "RATE MOVIE",
              HOME_SCREEN_BACKGROUND_COLOR,
              const Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        ),
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailsScreenButtonView(this.title, this.backgroundColor,
      this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(MARGIN_LARGE),
          border:
          isGhostButton ? Border.all(color: Colors.white, width: 2) : null),
      child: Center(
        child: Row(children: [
          buttonIcon,
          const SizedBox(width: MARGIN_MEDIUM),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: TEXT_REGULAR_2X),
          )
        ]),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  final String storyLine;

  const StoryLineView({super.key, required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        const SizedBox(height: MARGIN_MEDIUM),
        Text(
          storyLine,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        const SizedBox(width: MARGIN_SMALL),
        const Text(
          "2h 30min",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: MARGIN_MEDIUM),
        ...genreList
            .map(
              (genre) => GenreChipView(genre),
        )
            .toList(),
        const Icon(
          Icons.favorite_border,
          color: Colors.white,
        )
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  const GenreChipView(this.genreText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
          label: Text(
            genreText,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: MARGIN_SMALL),
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? movie;

  const MovieDetailsSliverAppBarView(
      {super.key, required this.movie, required this.onTapBack});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: PRIMARY_COLOR,
      pinned: false,
      floating: true,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: (movie != null)
            ? Stack(
          children: [
            Positioned.fill(
              child: MovieDetailsAppBarImageView(
                imageUrl: movie?.posterPath ?? "",
              ),
            ),
            const Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: MARGIN_MEDIUM_2, top: MARGIN_XXLARGE),
                child: BackButtonView(() => onTapBack()),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MARGIN_XXLARGE + MARGIN_MEDIUM,
                    right: MARGIN_MEDIUM_2),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: MARGIN_MEDIUM_2,
                    left: MARGIN_MEDIUM_2,
                    bottom: MARGIN_LARGE),
                child: MovieDetailsAppBarInfoView(
                  movie: movie,
                ),
              ),
            )
          ],
        )
            : const Center(
          child: CircularProgressIndicator(
            color: PLAY_BUTTON_COLOR,
          ),
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  final MovieVO? movie;

  const MovieDetailsAppBarInfoView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MovieDetailsYearView(
              year: movie?.releaseDate?.substring(0, 4) ?? "",
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const RatingView(),
                      const SizedBox(height: MARGIN_SMALL),
                      TitleText("${movie?.voteCount} VOTES"),
                      const SizedBox(
                        height: MARGIN_CARD_MEDIUM,
                      )
                    ]),
                const SizedBox(width: MARGIN_MEDIUM),
                Text(
                  movie?.voteAverage?.toStringAsFixed(1) ?? "",
                  style: const TextStyle(
                      fontSize: MOIVE_DETAILS_RATING_TEXT_SIZE,
                      color: Colors.white),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        Text(
          movie?.title ?? "",
          style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_2X,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  final String year;

  const MovieDetailsYearView({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XLARGE + 2,
      decoration: BoxDecoration(
          color: PLAY_BUTTON_COLOR,
          borderRadius: BorderRadius.circular(MARGIN_LARGE)),
      child: Center(
        child: Text(
          year,
          style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  Function onTapBack;

  BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBack();
      },
      child: Container(
        height: MARGIN_XXLARGE,
        width: MARGIN_XXLARGE,
        decoration:
        const BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
        child: const Icon(Icons.chevron_left,
            color: Colors.white, size: MARGIN_XLARGE),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  final String imageUrl;

  const MovieDetailsAppBarImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imageUrl",
      fit: BoxFit.cover,
    );
  }
}
