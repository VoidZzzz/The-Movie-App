import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_movie_app/network/data_agents/http_movie_data_agent_impl.dart';
import 'package:the_movie_app/pages/home_page.dart';
import 'package:the_movie_app/pages/movie_details_page.dart';
import 'package:the_movie_app/persistence/hive_constants.dart';
import 'data/data.vos/actor_vo.dart';
import 'data/data.vos/collection_vo.dart';
import 'data/data.vos/date_vo.dart';
import 'data/data.vos/genre_vo.dart';
import 'data/data.vos/movie_vo.dart';
import 'data/data.vos/production_company_vo.dart';
import 'data/data.vos/production_country_vo.dart';
import 'data/data.vos/spoken_language_vo.dart';
import 'network/data_agents/dio_movie_data_agent_impl.dart';
import 'network/data_agents/retrofit_movie_data_agent_impl.dart';

void main() async {
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
// flutter packages run build_runner build --delete-conflicting-outputs