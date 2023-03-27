import 'package:flutter/material.dart';
import 'package:the_movie_app/network/api_constants.dart';
import 'package:the_movie_app/resources/colors.dart';

import '../data/data.vos/actor_vo.dart';
import '../resources/dimens.dart';

class ActorView extends StatelessWidget {
  final ActorVO? actor;
  const ActorView({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: ACTORS_LIST_ITEMS_WIDTH,
      child: Stack(
        children: [
          Positioned.fill(
            child: ActorImageView(actorProfilePath: actor?.profilePath ?? "",),
          ),
          const Padding(
            padding: EdgeInsets.all(MARGIN_MEDIUM),
            child: Align(
              alignment: Alignment.topRight,
              child: FavouriteButtonView(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActorNameAndLikeView(actorName: actor?.name ?? "",),
          )
        ],
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  final String actorProfilePath;
  const ActorImageView({super.key, required this.actorProfilePath});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$actorProfilePath",
      fit: BoxFit.cover,
    );
  }
}

class FavouriteButtonView extends StatelessWidget {
  const FavouriteButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.favorite_border, color: Colors.white);
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  final String actorName;
  const ActorNameAndLikeView({super.key, required this.actorName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            actorName,
            style: const TextStyle(
                fontSize: TEXT_REGULAR,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: const [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MARGIN_CARD_MEDIUM,
              ),
              SizedBox(width: MARGIN_MEDIUM),
              Text(
                "YOU LIKED 13 MOVIES",
                style: TextStyle(
                    color: HOME_SCREEN_LIST_TITLE_COLOR,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
