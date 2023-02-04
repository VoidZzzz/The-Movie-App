import 'package:flutter/material.dart';
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
import '../resources/strings.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomePage extends StatelessWidget {
  List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];

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
                const BannerSectionView(),
                const SizedBox(height: MARGIN_LARGE),
                const BestPopularMoviesAndSerialsSectionView(),
                const SizedBox(height: MARGIN_LARGE),
                const CheckMovieShowtimesSectionView(),
                const SizedBox(height: MARGIN_LARGE),
                GenreSectionView(genreList: genreList),
                const SizedBox(height: MARGIN_LARGE),
                const ShowCasesSection(),
                const SizedBox(height: MARGIN_LARGE),
                ActorsAndCreatorsSectionView(BEST_ACTORS_TITLES, BEST_ACTORS_SEE_MORE)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenreSectionView extends StatelessWidget {
  const GenreSectionView({
    super.key,
    required this.genreList,
  });

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList.length,
            child: TabBar(
              isScrollable: true,indicatorColor: PLAY_BUTTON_COLOR,unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                  .map(
                    (genre) => Tab(
                      child: Text(genre),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Container(
            color: PRIMARY_COLOR,
            padding: const EdgeInsets.only(
                top: MARGIN_MEDIUM_2, bottom: MARGIN_LARGE),
            child: HorizontalMovieListView())
      ],
    );
  }
}

class CheckMovieShowtimesSectionView extends StatelessWidget {
  const CheckMovieShowtimesSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      height: SHOWTIME_SECTION_HEIGHT,
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
          Spacer(),
          Icon(
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
  const ShowCasesSection({super.key});

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
          children: const [ShowCaseView(), ShowCaseView(), ShowCaseView()],
        ),
      ),
    ]);
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  const BestPopularMoviesAndSerialsSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            child: const TitleText(MAIN_SCREEN_BEST_POPULAR_MOVIE_AND_SERIALS)),
        const SizedBox(height: MARGIN_MEDIUM_2),
        const HorizontalMovieListView(),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  const HorizontalMovieListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MOVIE_LIST_HEIGHT,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return const MovieView();
          }),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  const BannerSectionView({super.key});

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
            children: const [
              BannerView(),
              BannerView(),
            ],
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: 2,
          position: _position,
          decorator: const DotsDecorator(
              color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
              activeColor: PLAY_BUTTON_COLOR),
        )
      ],
    );
  }
}
