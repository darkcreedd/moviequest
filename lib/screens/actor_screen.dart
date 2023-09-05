import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviequest/custom_widgets/general_bottom_navigation_bar.dart';
import 'package:moviequest/screens/all_expansion_direct.dart';
import 'package:moviequest/screens/movie_screen.dart';
import 'package:moviequest/statemanagement/dataclass.dart';
import 'package:moviequest/statemanagement/models/about_actor_model.dart';
import 'package:moviequest/statemanagement/models/actor_credits_model.dart';
import 'package:moviequest/statemanagement/models/search_results_model.dart';
import 'package:moviequest/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ActorPage extends StatefulWidget {
  const ActorPage({super.key, required this.castId});
  final int castId;

  @override
  State<ActorPage> createState() => _ActorPageState();
}

class _ActorPageState extends State<ActorPage> {
  Future<ActorCredits?>? actorCredits;
  Future<AboutActor?>? aboutActor;

  @override
  void initState() {
    aboutActor = Provider.of<DataClass>(context, listen: false)
        .fetchActorDetails(widget.castId);
    actorCredits = Provider.of<DataClass>(context, listen: false)
        .fetchActorCredits(widget.castId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: KColors.dark1,
          centerTitle: true,
          title: const Text('Cast Profile'),
        ),
        backgroundColor: KColors.dark1,
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: aboutActor,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                      );
                    case ConnectionState.none:
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                      );
                    case ConnectionState.done:
                      return (snapshot.hasData)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: CachedNetworkImage(
                                    imageUrl: (snapshot.data!.profilePath !=
                                            null)
                                        ? 'https://image.tmdb.org/t/p/w500${snapshot.data!.profilePath}'
                                        : '',
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'assets/images/3828541.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (snapshot.data!.name != null)
                                        ? snapshot.data!.name!
                                        : 'Unknown',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ReadMoreText(
                                  (snapshot.data!.biography != null)
                                      ? snapshot.data!.biography!
                                      : 'Not available',
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(color: Colors.white),
                                  trimLines: 10,
                                  colorClickableText: KColors.pyellow,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: 'Show less',
                                  lessStyle: TextStyle(
                                      color: KColors.pyellow,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  moreStyle: TextStyle(
                                      color: KColors.pyellow,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          : Center(
                              child: Text(
                                snapshot.error.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            );

                    case ConnectionState.waiting:
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Loading...',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            ),
                          )
                        ],
                      );
                  }
                },
              ),
              FutureBuilder(
                future: actorCredits,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                      );
                    case ConnectionState.none:
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                      );
                    case ConnectionState.done:
                      return (snapshot.hasData)
                          ? SizedBox(
                              height: 300,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Movies featured',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: KColors.pyellow),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AllExpansionD(
                                                          keyword:
                                                              'Movies featured',
                                                          results:
                                                              actorCredits),
                                                ));
                                          },
                                          child: Text(
                                            'All',
                                            style: TextStyle(
                                                color: KColors.pyellow,
                                                fontSize: 17),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: (snapshot.data!.cast.length >
                                              4)
                                          ? (snapshot.data!.cast.length -
                                                  (snapshot.data!.cast.length *
                                                      0.5))
                                              .ceil()
                                          : snapshot.data!.cast.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        var datax = snapshot.data!.cast[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => MovieScreen(
                                                      movieId: snapshot
                                                          .data!.cast[index].id,
                                                      results: Result(
                                                          originalTitle: datax
                                                              .originalTitle!,
                                                          adult: false,
                                                          id: datax.id,
                                                          originalLanguage: datax
                                                              .originalLanguage!,
                                                          posterPath:
                                                              datax.posterPath,
                                                          overview:
                                                              datax.overview!,
                                                          backdropPath: datax
                                                              .backdropPath,
                                                          voteAverage:
                                                              datax.voteAverage,
                                                          voteCount:
                                                              datax.voteCount!,
                                                          video: datax.video!,
                                                          genreIds:
                                                              datax.genreIds,
                                                          popularity:
                                                              datax.popularity!,
                                                          releaseDate: datax
                                                              .releaseDate!,
                                                          title: datax.title!)),
                                                ));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(8),
                                            height: 250,
                                            width: 170,
                                            color: Colors.transparent,
                                            child: Column(children: [
                                              Expanded(
                                                child: CachedNetworkImage(
                                                  imageUrl: (snapshot
                                                              .data!
                                                              .cast[index]
                                                              .posterPath !=
                                                          null)
                                                      ? 'https://image.tmdb.org/t/p/w500${snapshot.data!.cast[index].posterPath}'
                                                      : 'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1683318510~exp=1683319110~hmac=f6c70084be88756c84cfac45113e2e261407f4b0b190c546da47bec644dd1238',
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          'assets/images/3828541.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data!.cast[index]
                                                        .originalTitle ??
                                                    snapshot.data!.cast[index]
                                                        .title ??
                                                    '',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                (snapshot.data!.cast[index]
                                                            .character !=
                                                        null)
                                                    ? snapshot.data!.cast[index]
                                                        .character!
                                                    : 'Unknown',
                                                style: TextStyle(
                                                    color: Colors.grey[400]),
                                              )
                                            ]),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Center(
                              child: Text(
                                snapshot.error.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            );

                    case ConnectionState.waiting:
                      return SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Movies featured',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: KColors.pyellow),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'All',
                                      style: TextStyle(
                                          color: KColors.pyellow, fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 6,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(8),
                                    height: 250,
                                    width: 170,
                                    color: Colors.transparent,
                                    child: const Center(
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CircularProgressIndicator(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const MainBottomNavBar(),
      ),
    );
  }
}
