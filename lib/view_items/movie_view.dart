import 'package:flutter/material.dart';
import 'package:the_movie_app/network/api_constants.dart';
import 'package:the_movie_app/widgets/rating_view.dart';
import '../data/data.vos/movie_vo.dart';
import '../resources/dimens.dart';

class MovieView extends StatelessWidget {
  final MovieVO? movie;
  final Function onTapMovie;

  const MovieView({super.key, required this.movie, required this.onTapMovie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              onTapMovie();
            },
            child: Image.network(
              "$IMAGE_BASE_URL${movie?.posterPath ?? ""}",
              fit: BoxFit.cover,
              height: 197,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          SizedBox(
            width: 131,
            child: InkWell(
              onTap: () {
                onTapMovie();
              },
              child: Text(
                movie?.title ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR_2X,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM - 5),
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
