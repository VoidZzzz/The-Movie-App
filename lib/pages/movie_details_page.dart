import 'package:flutter/material.dart';
import 'package:the_movie_app/resources/colors.dart';
import 'package:the_movie_app/resources/dimens.dart';
import 'package:the_movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:the_movie_app/widgets/gradient_view.dart';
import 'package:the_movie_app/widgets/raing_view.dart';
import 'package:the_movie_app/widgets/title_text.dart';
import 'package:the_movie_app/resources/strings.dart';

class MovieDetailsPage extends StatelessWidget {
  final List<String> genreList = [
    "Action",
    "Adventure",
    "Thriller",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetailsSliverAppBarView(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: TrailerSection(genreList),
                  ),
                  ActorsAndCreatorsSectionView(
                      MOVIE_DETAILS_SCREEN_ACTORS_TITLE, "",
                      seeMoreButtonVisibility: false),
                  ActorsAndCreatorsSectionView(
                      MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                      MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrailerSection extends StatelessWidget {
  final List<String> genreList;
  TrailerSection(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        SizedBox(height: MARGIN_MEDIUM_3),
        StoryLineView(),
        SizedBox(height: MARGIN_MEDIUM_2),
        Row(children: [
          PlayTrailerButtonView()
        ],
        ),
      ],
    );
  }
}

class PlayTrailerButtonView extends StatelessWidget {
  const PlayTrailerButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
          color: PLAY_BUTTON_COLOR,
          borderRadius: BorderRadius.circular(MARGIN_LARGE)),
      child: Center(
        child: Row(children: [
          Icon(
            Icons.play_circle_fill,
            color: Colors.black54,
          ),
          SizedBox(width: MARGIN_MEDIUM),
          Text(
            "PLAY TRAILER",
            style: TextStyle(
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
  const StoryLineView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          "Lured to a Japan he hasn't seen since World War II, century-old mutant Wolverine (Hugh Jackman) finds himself in a shadowy realm of yakuza and samurai. Wolverine is pushed to his physical and emotional brink when he is forced to go on the run with a powerful industrialist's daughter (Tao Okamoto) and is confronted -- for the first time -- with the prospect of death. As he struggles to rediscover the hero within himself, he must grapple with powerful foes and the ghosts of his own haunted past.",
          style: TextStyle(color: Colors.white),
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
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        SizedBox(width: MARGIN_MEDIUM_SMALL),
        Text(
          "2h 30min",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Row(
          children: genreList
              .map(
                (genre) => GenreChipView(genre),
              )
              .toList(),
        ),
        Spacer(),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        )
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;
  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
          label: Text(
            genreText,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM_SMALL),
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  const MovieDetailsSliverAppBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      pinned: false,
      floating: true,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetailsAppBarImageView(),
            ),
            Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(left: MARGIN_MEDIUM_2, top: MARGIN_XXLARGE),
                child: BackButtonView(),
              ),
            ),
            Align(
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
                child: MovieDetailsAppBaInfoView(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBaInfoView extends StatelessWidget {
  const MovieDetailsAppBaInfoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MovieDetailsYearView(),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingView(),
                      SizedBox(height: MARGIN_MEDIUM_SMALL),
                      TitleText("38879 votes"),
                      SizedBox(
                        height: MARGIN_CARD_MEDIUM,
                      )
                    ]),
                SizedBox(width: MARGIN_MEDIUM),
                Text(
                  "9,76",
                  style: TextStyle(
                      fontSize: MOIVE_DETAILS_RATING_TEXT_SIZE,
                      color: Colors.white),
                )
              ],
            )
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          "The Wolverine",
          style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_2X,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  const MovieDetailsYearView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
          color: PLAY_BUTTON_COLOR,
          borderRadius: BorderRadius.circular(MARGIN_LARGE)),
      child: Center(
        child: Text(
          "2016",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
    return Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  const BackButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXLARGE,
      width: MARGIN_XXLARGE,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
      child: Icon(Icons.chevron_left, color: Colors.white, size: MARGIN_XLARGE),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  const MovieDetailsAppBarImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://media.gq.com/photos/58b9fda8803bdb766dd69ef7/16:9/w_1280,c_limit/wolverine.jpg",
      fit: BoxFit.cover,
    );
  }
}
