import 'package:flutter/material.dart';
import 'package:the_movie_app/widgets/title_text_with_see_more_view.dart';
import '../data/data.vos/actor_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../view_items/actor_view.dart';

class ActorsAndCreatorsSectionView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;
  final List<ActorVO>? actorList;

  const ActorsAndCreatorsSectionView(
      {super.key,
      required this.titleText,
      required this.seeMoreText,
      this.seeMoreButtonVisibility = true,
      required this.actorList});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding:
          const EdgeInsets.only(top: MARGIN_MEDIUM_2, bottom: MARGIN_XXLARGE),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithSeeMoreView(
              titleText,
              seeMoreText,
              seeMoreButtonVisibility: seeMoreButtonVisibility,
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM_2),
          SizedBox(
            height: BEST_ACTORS_HEIGHT,
            child: (actorList != null)
                ? ListView(
                    padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                    scrollDirection: Axis.horizontal,
                    children: actorList
                            ?.map(
                              (actor) => ActorView(
                                actor: actor,
                              ),
                            )
                            .toList() ??
                        [],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: PLAY_BUTTON_COLOR,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
