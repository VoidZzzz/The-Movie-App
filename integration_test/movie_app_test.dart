import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:integration_test/integration_test.dart';
import 'package:the_movie_app/data/data.vos/actor_vo.dart';
import 'package:the_movie_app/data/data.vos/collection_vo.dart';
import 'package:the_movie_app/data/data.vos/date_vo.dart';
import 'package:the_movie_app/data/data.vos/genre_vo.dart';
import 'package:the_movie_app/data/data.vos/movie_vo.dart';
import 'package:the_movie_app/data/data.vos/production_company_vo.dart';
import 'package:the_movie_app/data/data.vos/production_country_vo.dart';
import 'package:the_movie_app/data/data.vos/spoken_language_vo.dart';
import 'package:the_movie_app/main.dart';
import 'package:the_movie_app/pages/home_page.dart';
import 'package:the_movie_app/persistence/hive_constants.dart';

import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());

  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);

  testWidgets("Tap Best Popular Movies And Navigate to Details Test", (WidgetTester tester) async {

    // Pumping widget to Screen
    await tester.pumpWidget(const MyApp());
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Finding Specific Widget
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text(TEST_DATA_POPULAR_MOVIE_NAME), findsOneWidget);

    // Tapping the Widget and Waiting to settle
    await tester.tap(find.text(TEST_DATA_POPULAR_MOVIE_NAME));
    await tester.pumpAndSettle(const Duration(seconds: 5));


    // Checking if it is the expected screen or not
    expect(find.text(TEST_DATA_POPULAR_MOVIE_NAME), findsOneWidget);
    expect(find.text(TEST_DATA_POPULAR_RATING), findsOneWidget);
    expect(find.text(TEST_DATA_POPULAR_RELEASED_YEAR), findsOneWidget);
  });
}