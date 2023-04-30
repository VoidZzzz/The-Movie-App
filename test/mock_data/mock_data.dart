import 'package:the_movie_app/data/data.vos/actor_vo.dart';
import 'package:the_movie_app/data/data.vos/genre_vo.dart';
import 'package:the_movie_app/data/data.vos/movie_vo.dart';

List<MovieVO> getMockMoviesForTest() {
  return [
    MovieVO(
        false,
        "/iJQIbOPm81fPEGKt5BPuZmfnA54.jpg",
        [16, 12, 10751, 14, 35],
        502356,
        "en",
        "The Super Mario Bros. Movie",
        "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
        6572.614,
        "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
        "2023-04-05",
        "The Super Mario Bros. Movie",
        false,
        7.5,
        1546,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        true,
        false,
        false),
    MovieVO(
        false,
        "/nDxJJyA5giRhXx96q1sWbOUjMBI.jpg",
        [28, 35, 14],
        594767,
        "en",
        "Shazam! Fury of the Gods",
        "Billy Batson and his foster siblings, who transform into superheroes by saying \"Shazam!\", are forced to get back into action and fight the Daughters of Atlas, who they must stop from using a weapon that could destroy the world.",
        4274.232,
        "/2VK4d3mqqTc7LVZLnLPeRiPaJ71.jpg",
        "2023-03-15",
        "Shazam! Fury of the Gods",
        false,
        6.9,
        1231,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        false,
        true,
        false),
    MovieVO(
        false,
        "/7bWxAsNPv9CXHOhZbJVlj2KxgfP.jpg",
        [27, 53],
        713704,
        "en",
        "Evil Dead Rise",
        "Two sisters find an ancient vinyl that gives birth to bloodthirsty demons that run amok in a Los Angeles apartment building and thrusts them into a primal battle for survival as they face the most nightmarish version of family imaginable.",
        1696.367,
        "/mIBCtPvKZQlxubxKMeViO2UrP3q.jpg",
        "2023-04-12",
        "Evil Dead Rise",
        false,
        7.9,
        2121,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        false,
        false,
        true)
  ];
}

List<ActorVO> getMockActors() {
  return [
    ActorVO(false, 224513, [], 343.33, "Ana de Armas",
        "/3vxvsmYLTf4jnr163SUlBIw51ee.jpg", null, null, null, null, null, null),
    ActorVO(false, 2710789, [], 268, "Seung Ha",
        "/hpMpnHprRlCzvNVlx6C3RWmswOF.jpg", null, null, null, null, null, null),
    ActorVO(false, 58021, [], 232, "Tinto Brass",
        "/adQ1j2FQ1FZ67hlZVhsUnALM4G4.jpg", null, null, null, null, null, null)
  ];
}

List<GenreVO> getMockGenres() {
  return [
    GenreVO(id: 1, name: "Action"),
    GenreVO(id: 2, name: "Adventure"),
    GenreVO(id: 3, name: "Comedy")
  ];
}

List<List<ActorVO>> getMockCredits() {
  return [
    [
      ActorVO(false, 224513, [], 343.33, "Ana de Armas",
          "/3vxvsmYLTf4jnr163SUlBIw51ee.jpg", null, null, null, null, null, null),
      ActorVO(false, 2710789, [], 268, "Seung Ha",
          "/hpMpnHprRlCzvNVlx6C3RWmswOF.jpg", null, null, null, null, null, null),
      ActorVO(false, 58021, [], 232, "Tinto Brass",
          "/adQ1j2FQ1FZ67hlZVhsUnALM4G4.jpg", null, null, null, null, null, null)
    ],
    [
      ActorVO(
          false,
          974169,
          [],
          260,
          "Jenna Ortega",
          "/q1NRzyZQlYkxLY07GO9NVPkQnu8.jpg",
          "Acting",
          "Scott Ly",
          null,
          null,
          null,
          null),
      ActorVO(
          false,
          1907997,
          [],
          138.232,
          "Min Do-yoon",
          "/bHHn3krbHyxQIWb4JbHkPlV6Uu1.jpg",
          "Creating",
          null,
          null,
          null,
          null,
          null),
      ActorVO(
          false,
          115440,
          [],
          160,
          "Sydney Sweeney",
          "/afr2eoktU4lFYtmtfKo05EbQdXo.jpg",
          "Acting",
          null,
          null,
          null,
          null,
          null)
    ]
  ];
}
