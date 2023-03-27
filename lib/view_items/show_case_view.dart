import 'package:flutter/material.dart';
import 'package:the_movie_app/network/api_constants.dart';
import 'package:the_movie_app/resources/dimens.dart';
import 'package:the_movie_app/widgets/play_button_view.dart';
import 'package:the_movie_app/widgets/title_text.dart';

import '../data/data.vos/movie_vo.dart';

class ShowCaseView extends StatelessWidget {
  final MovieVO? movie;
  final Function onTapShowCase;
  const ShowCaseView({super.key, required this.movie, required this.onTapShowCase});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: 300,
      child: GestureDetector(
        onTap: () {
          onTapShowCase();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                "$IMAGE_BASE_URL${movie?.posterPath}",
                fit: BoxFit.cover,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: PlayButtonView(),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movie?.title ?? "",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: TEXT_REGULAR_3X,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: MARGIN_MEDIUM),
                    const TitleText("15 December 2016")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
