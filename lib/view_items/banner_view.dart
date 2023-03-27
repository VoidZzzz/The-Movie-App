import 'package:flutter/material.dart';
import 'package:the_movie_app/data/data.vos/movie_vo.dart';
import 'package:the_movie_app/network/api_constants.dart';
import 'package:the_movie_app/resources/colors.dart';
import 'package:the_movie_app/resources/dimens.dart';
import 'package:the_movie_app/widgets/gradient_view.dart';
import '../widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  final Function onTapBanner;
  final MovieVO? movie;
  const BannerView({super.key, required this.onTapBanner, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){onTapBanner();},
      child: Stack(
        children: [
          Positioned.fill(
            child: BannerImageView(imageUrl: movie?.posterPath ?? "",),
          ),
          const Positioned.fill(
            child: GradientView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: BannerTitleView(movieTitle: movie?.title ?? "",),
          ),
          const Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          )
        ],
      ),
    );
  }
}


class BannerTitleView extends StatelessWidget {
  final String movieTitle;
  const BannerTitleView({super.key, required this.movieTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            movieTitle,
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_1X,
                fontWeight: FontWeight.w500),
          ),
          const Text(
            "Official",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_1X,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {
  final String imageUrl;
  const BannerImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imageUrl",
      fit: BoxFit.cover,
    );
  }
}
