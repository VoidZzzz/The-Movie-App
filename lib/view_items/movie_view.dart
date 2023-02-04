import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:the_movie_app/widgets/raing_view.dart';
import '../resources/dimens.dart';

class MovieView extends StatelessWidget {
  const MovieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "https://assets.reedpopcdn.com/Deadpool_Wolverine_Headline.jpg/BROK/resize/1200x1200%3E/format/jpg/quality/70/Deadpool_Wolverine_Headline.jpg",
            fit: BoxFit.cover,
            height: 200,
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          const Text(
            "West World",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: const [
              Text(
                '8.9',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: TEXT_REGULAR,
                    color: Colors.white),
              ),
              SizedBox(width: MARGIN_MEDIUM),
              RatingView()
            ],
          ),
        ],
      ),
    );
  }
}
