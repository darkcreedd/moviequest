import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviequest/custom_widgets/general_bottom_navigation_bar.dart';
import 'package:moviequest/statemanagement/dataclass.dart';
import 'package:moviequest/statemanagement/models/Series_Models/credits_results_model_series.dart';
import 'package:moviequest/statemanagement/models/Series_Models/series_search_results.dart';
import 'package:moviequest/statemanagement/models/credits_results_model.dart';
import 'package:moviequest/utils/colors.dart';
import 'package:provider/provider.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../statemanagement/models/search_results_model.dart';
import '../statemanagement/models/videos.dart';
import 'actor_screen.dart';
import 'all_expansion.dart';
import 'all_expansion_cast_and_crew_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key, required this.movieId, required this.results});
  final int movieId;
  final Result results;
  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
//   final YoutubePlayerController _controller = YoutubePlayerController(
//       initialVideoId: 'seBixtcx19E',
//       flags: const YoutubePlayerFlags(autoPlay: false, mute: true));
  Future<CreditsResults?>? movieCreditsResults;
  Future<SearchResults?>? similarMovies;
  Future<Videos?>? videos;
  String? genres;

  //For Series
  Future<CreditResultS?>? creditsSeriesResults;
  Future<SeriesResult?>? similarSeries;
  @override
  void initState() {
    movieCreditsResults = Provider.of<DataClass>(context, listen: false)
        .fetchCredits(widget.movieId);
    similarMovies = Provider.of<DataClass>(context, listen: false)
        .fetchSimilarMovies(widget.movieId);
    // Implement an isMovie/isSeries flag to control which future to execute

    //For series
    creditsSeriesResults = Provider.of<DataClass>(context, listen: false)
        .fetchSeriesCredits(widget.movieId);
    similarSeries = Provider.of<DataClass>(context, listen: false)
        .fetchSimilarTVShows(widget.movieId);

    // videos = Provider.of<DataClass>(context, listen: false)
    //     .fetchVideos(widget.movieId);
    genres = Provider.of<DataClass>(context, listen: false)
        .getGenreNamesByIds(widget.results.genreIds);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KColors.dark1,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leadingWidth: 50,
              snap: false,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.softLight),
                  child: Container(
                    margin: const EdgeInsets.only(left: 50),
                    child: Text(widget.results.originalTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ) //TextStyle
                        ),
                  ),
                ), //Text
                background: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${widget.results.posterPath}',
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/3828541.jpg',
                    fit: BoxFit.fill,
                  ),
                  fit: BoxFit.fill,
                ),
              ), //FlexibleSpaceBar
              expandedHeight: 350,
              backgroundColor: KColors.dark1,
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Consumer<DataClass>(
              builder: (context, value, child) => SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'IMDb',
                                  style: TextStyle(
                                      color: KColors.pyellow, fontSize: 15.5),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.results.voteAverage.toStringAsFixed(1),
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 14),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          genres!,
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 14),
                                        ),
                                        Text(
                                          '${widget.results.releaseDate} ${widget.results.originalLanguage.toUpperCase()}',
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                minimumSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                backgroundColor: KColors.dblue1),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Watch for free'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.play_arrow_outlined,
                                  size: 30,
                                  color: KColors.pyellow,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
                          child: Text(
                            'Movie Info',
                            style:
                                TextStyle(color: KColors.pyellow, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              widget.results.overview,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Trailer',
                            style:
                                TextStyle(color: KColors.pyellow, fontSize: 15),
                          ),
                        ),

                        ///here

                        (value.pageIndexM == 0)
                            ? FutureBuilder(
                                future: movieCreditsResults,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    genres = Provider.of<DataClass>(context,
                                            listen: false)
                                        .getGenreNamesByIds(
                                            widget.results.genreIds);
                                  }
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FutureBuilder(
                                                  future: videos,
                                                  builder: (context, snapshot) {
                                                    switch (snapshot
                                                        .connectionState) {
                                                      case ConnectionState
                                                            .active:
                                                        return const Center(
                                                          child: SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        );
                                                      case ConnectionState.none:
                                                        return const Center(
                                                          child: SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        );
                                                      case ConnectionState.done:
                                                        return (snapshot
                                                                .hasData)
                                                            ? Container(
                                                                margin: const EdgeInsets
                                                                        .fromLTRB(
                                                                    20,
                                                                    0,
                                                                    20,
                                                                    0),
                                                                height: 250,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                color: Colors
                                                                    .black,
                                                                // child: YoutubePlayer(
                                                                //   controller:
                                                                //       YoutubePlayerController(
                                                                //     initialVideoId:
                                                                //         'seBixtcx19E',
                                                                //     flags:
                                                                //         const YoutubePlayerFlags(
                                                                //             autoPlay: false,
                                                                //             mute: true),
                                                                //   ),
                                                                //   showVideoProgressIndicator:
                                                                //       true,
                                                                // ),
                                                              )
                                                            : Center(
                                                                child: Text(
                                                                  snapshot.error
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              );

                                                      case ConnectionState
                                                            .waiting:
                                                        return const Center(
                                                          child: SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        );
                                                    }
                                                  },
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 20, 0, 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Cast & Crew',
                                                        style: TextStyle(
                                                            color:
                                                                KColors.pyellow,
                                                            fontSize: 15),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => AllCastAndCrewExpansion(
                                                                    keyword:
                                                                        'Cast & Crew',
                                                                    results: snapshot
                                                                        .data!
                                                                        .cast),
                                                              ));
                                                        },
                                                        child: Text(
                                                          'All',
                                                          style: TextStyle(
                                                              color: KColors
                                                                  .pyellow,
                                                              fontSize: 17),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 20),
                                                  height: 220,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: (snapshot.data!
                                                                .cast.length >
                                                            4)
                                                        ? (snapshot.data!.cast
                                                                    .length -
                                                                (snapshot
                                                                        .data!
                                                                        .cast
                                                                        .length *
                                                                    0.5))
                                                            .ceil()
                                                        : snapshot
                                                            .data!.cast.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ActorPage(
                                                                      castId: snapshot
                                                                          .data!
                                                                          .cast[
                                                                              index]
                                                                          .id),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          height: 220,
                                                          width: 130,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: (snapshot.data!.cast[index].profilePath !=
                                                                            null)
                                                                        ? 'https://image.tmdb.org/t/p/w500${snapshot.data!.cast[index].profilePath}'
                                                                        : 'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1683318510~exp=1683319110~hmac=f6c70084be88756c84cfac45113e2e261407f4b0b190c546da47bec644dd1238',
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Image.asset(
                                                                            'assets/images/3828541.jpg'),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .cast[
                                                                          index]
                                                                      .originalName,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        4.0,
                                                                        0,
                                                                        4,
                                                                        4),
                                                                child: Text(
                                                                  snapshot
                                                                          .data!
                                                                          .cast[
                                                                              index]
                                                                          .character ??
                                                                      'Unknown',
                                                                  style: TextStyle(
                                                                      color: KColors
                                                                          .pyellow),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Center(
                                              child: Text(
                                                '${snapshot.error.toString()} -- here',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );

                                    case ConnectionState.waiting:
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 20, 0, 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Cast & Crew',
                                                  style: TextStyle(
                                                      color: KColors.pyellow,
                                                      fontSize: 15),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllCastAndCrewExpansion(
                                                                  keyword:
                                                                      'Cast & Crew',
                                                                  results:
                                                                      snapshot
                                                                          .data!
                                                                          .cast),
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
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            height: 250,
                                            child: ListView.builder(
                                              itemCount: 5,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  height: 250,
                                                  width: 130,
                                                  color: KColors.dark1,
                                                  child: const SizedBox(
                                                      width: 150,
                                                      height: 240,
                                                      child: Center(
                                                        child: SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Colors.red,
                                                            )),
                                                      )),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                  }
                                },
                              )
                            : FutureBuilder(
                                future: creditsSeriesResults,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    genres = Provider.of<DataClass>(context,
                                            listen: false)
                                        .getGenreNamesByIds(
                                            widget.results.genreIds);
                                  }
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FutureBuilder(
                                                  future: videos,
                                                  builder: (context, snapshot) {
                                                    switch (snapshot
                                                        .connectionState) {
                                                      case ConnectionState
                                                            .active:
                                                        return const Center(
                                                          child: SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        );
                                                      case ConnectionState.none:
                                                        return const Center(
                                                          child: SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        );
                                                      case ConnectionState.done:
                                                        return (snapshot
                                                                .hasData)
                                                            ? Container(
                                                                margin: const EdgeInsets
                                                                        .fromLTRB(
                                                                    20,
                                                                    0,
                                                                    20,
                                                                    0),
                                                                height: 250,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                color: Colors
                                                                    .black,
                                                                // child: YoutubePlayer(
                                                                //   controller:
                                                                //       YoutubePlayerController(
                                                                //     initialVideoId:
                                                                //         'seBixtcx19E',
                                                                //     flags:
                                                                //         const YoutubePlayerFlags(
                                                                //             autoPlay: false,
                                                                //             mute: true),
                                                                //   ),
                                                                //   showVideoProgressIndicator:
                                                                //       true,
                                                                // ),
                                                              )
                                                            : Center(
                                                                child: Text(
                                                                  snapshot.error
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              );

                                                      case ConnectionState
                                                            .waiting:
                                                        return const Center(
                                                          child: SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        );
                                                    }
                                                  },
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 20, 0, 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Cast & Crew',
                                                        style: TextStyle(
                                                            color:
                                                                KColors.pyellow,
                                                            fontSize: 15),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => AllCastAndCrewExpansionSeries(
                                                                    keyword:
                                                                        'Cast & Crew',
                                                                    results: snapshot
                                                                        .data!
                                                                        .cast),
                                                              ));
                                                        },
                                                        child: Text(
                                                          'All',
                                                          style: TextStyle(
                                                              color: KColors
                                                                  .pyellow,
                                                              fontSize: 17),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 20),
                                                  height: 220,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: (snapshot.data!
                                                                .cast.length >
                                                            4)
                                                        ? (snapshot.data!.cast
                                                                    .length -
                                                                (snapshot
                                                                        .data!
                                                                        .cast
                                                                        .length *
                                                                    0.5))
                                                            .ceil()
                                                        : snapshot
                                                            .data!.cast.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ActorPage(
                                                                      castId: snapshot
                                                                          .data!
                                                                          .cast[
                                                                              index]
                                                                          .id),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          height: 220,
                                                          width: 130,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: (snapshot.data!.cast[index].profilePath !=
                                                                            null)
                                                                        ? 'https://image.tmdb.org/t/p/w500${snapshot.data!.cast[index].profilePath}'
                                                                        : 'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1683318510~exp=1683319110~hmac=f6c70084be88756c84cfac45113e2e261407f4b0b190c546da47bec644dd1238',
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Image.asset(
                                                                            'assets/images/3828541.jpg'),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .cast[
                                                                          index]
                                                                      .originalName,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        4.0,
                                                                        0,
                                                                        4,
                                                                        4),
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .cast[
                                                                          index]
                                                                      .character,
                                                                  style: TextStyle(
                                                                      color: KColors
                                                                          .pyellow),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Center(
                                              child: Text(
                                                '${snapshot.error.toString()} -- here',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );

                                    case ConnectionState.waiting:
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 20, 0, 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Cast & Crew',
                                                  style: TextStyle(
                                                      color: KColors.pyellow,
                                                      fontSize: 15),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllCastAndCrewExpansionSeries(
                                                                  keyword:
                                                                      'Cast & Crew',
                                                                  results:
                                                                      snapshot
                                                                          .data!
                                                                          .cast),
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
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            height: 250,
                                            child: ListView.builder(
                                              itemCount: 5,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  height: 250,
                                                  width: 130,
                                                  color: KColors.dark1,
                                                  child: const SizedBox(
                                                      width: 150,
                                                      height: 240,
                                                      child: Center(
                                                        child: SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Colors.red,
                                                            )),
                                                      )),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                  }
                                },
                              ),

                        ///
                        FutureBuilder(
                          future: similarMovies,
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
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 20, 0, 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'You might also like',
                                                  style: TextStyle(
                                                      color: KColors.pyellow,
                                                      fontSize: 15),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const AllExpansion(
                                                                    keyword:
                                                                        'You might also like'),
                                                          ));
                                                    },
                                                    child: Text(
                                                      'All',
                                                      style: TextStyle(
                                                          color:
                                                              KColors.pyellow,
                                                          fontSize: 17),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            height: 250,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: (snapshot.data!.results
                                                          .length >
                                                      4)
                                                  ? (snapshot.data!.results
                                                              .length -
                                                          (snapshot
                                                                  .data!
                                                                  .results
                                                                  .length *
                                                              0.5))
                                                      .ceil()
                                                  : snapshot
                                                      .data!.results.length,
                                              itemBuilder: (context, index) =>
                                                  GestureDetector(
                                                onTap: () {
                                                  var datax = snapshot
                                                      .data!.results[index];
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MovieScreen(
                                                        movieId: snapshot.data!
                                                            .results[index].id,
                                                        results: Result(
                                                            originalTitle: datax
                                                                .originalTitle,
                                                            adult: false,
                                                            id: datax.id,
                                                            originalLanguage: datax
                                                                .originalLanguage,
                                                            posterPath: datax
                                                                .posterPath,
                                                            overview:
                                                                datax.overview,
                                                            backdropPath: datax
                                                                .backdropPath,
                                                            voteAverage: datax
                                                                .voteAverage,
                                                            voteCount:
                                                                datax.voteCount,
                                                            video: datax.video,
                                                            genreIds:
                                                                datax.genreIds,
                                                            popularity: datax
                                                                .popularity,
                                                            releaseDate: datax
                                                                .releaseDate,
                                                            title: datax.title),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  height: 250,
                                                  width: 130,
                                                  color: KColors.dark1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: (snapshot
                                                                        .data!
                                                                        .results[
                                                                            index]
                                                                        .posterPath !=
                                                                    null)
                                                                ? 'https://image.tmdb.org/t/p/w500${snapshot.data!.results[index].posterPath}'
                                                                : 'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1683318510~exp=1683319110~hmac=f6c70084be88756c84cfac45113e2e261407f4b0b190c546da47bec644dd1238',
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    'assets/images/3828541.jpg'),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .results[index]
                                                            .originalTitle,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'IMDb',
                                                            style: TextStyle(
                                                                color: KColors
                                                                    .pyellow),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .data!
                                                                .results[index]
                                                                .voteAverage
                                                                .toStringAsFixed(
                                                                    1),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Center(
                                        child: Text(
                                          '${snapshot.error.toString()} -- here',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      );

                              case ConnectionState.waiting:
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 0, 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'You might also like',
                                            style: TextStyle(
                                                color: KColors.pyellow,
                                                fontSize: 15),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AllExpansion(
                                                              keyword:
                                                                  'You might also like'),
                                                    ));
                                              },
                                              child: Text(
                                                'All',
                                                style: TextStyle(
                                                    color: KColors.pyellow,
                                                    fontSize: 17),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      height: 250,
                                      child: ListView.builder(
                                        itemCount: 5,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            height: 250,
                                            width: 130,
                                            color: KColors.dark1,
                                            child: const SizedBox(
                                                width: 150,
                                                height: 240,
                                                child: Center(
                                                  child: SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.red,
                                                      )),
                                                )),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const MainBottomNavBar(),
      ),
    );
  }
}
