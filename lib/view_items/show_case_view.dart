import 'package:flutter/material.dart';
import 'package:the_movie_app/resources/dimens.dart';
import 'package:the_movie_app/widgets/play_button_view.dart';
import 'package:the_movie_app/widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: 300,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://assets.reedpopcdn.com/Deadpool_Wolverine_Headline.jpg/BROK/resize/1200x1200%3E/format/jpg/quality/70/Deadpool_Wolverine_Headline.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Align(
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
                    "Passengers",
                    style: TextStyle(color: Colors.white, fontSize: TEXT_REGULAR_3X,fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: MARGIN_MEDIUM),
                  TitleText("15 December 2016")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
