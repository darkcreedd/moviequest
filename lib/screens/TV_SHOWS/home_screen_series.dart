import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviequest/screens/TV_SHOWS/all_expansion_series.dart';
import 'package:moviequest/screens/movie_screen.dart';
import 'package:moviequest/statemanagement/models/Series_Models/series_search_results.dart';
import 'package:moviequest/statemanagement/models/search_results_model.dart';
import 'package:moviequest/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../statemanagement/dataclass.dart';

class HomeScreenSeries extends StatefulWidget {
  const HomeScreenSeries({super.key});

  @override
  State<HomeScreenSeries> createState() => _HomeScreenSeriesState();
}

class _HomeScreenSeriesState extends State<HomeScreenSeries> {
  bool isMovies = true;
  Future<SeriesResult?>? discoveryTVResults;
  Future<SeriesResult?>? topRatedTVResults;
  Future<SeriesResult?>? popularTVResults;

  @override
  void initState() {
    //Load everything from the onboarding screen later
    var dataclass = Provider.of<DataClass>(context, listen: false);
    discoveryTVResults = (dataclass.discoveryTVResults == null)
        ? discoveryTVResults = dataclass.fetchTVDiscoveries()
        : dataclass.discoveryTVResults;

    topRatedTVResults = (dataclass.topRatedTVResults == null)
        ? topRatedTVResults = dataclass.fetchTopRatedTV()
        : dataclass.topRatedTVResults;

    popularTVResults = (dataclass.popularTVResults == null)
        ? popularTVResults = dataclass.fetchPopularTV()
        : dataclass.popularTVResults;

    dataclass.mostSearchedTVResults = popularTVResults;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discover',
                  style: TextStyle(color: KColors.pyellow, fontSize: 17),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllExpansionSeries(
                                keyword: 'Discover',
                                results: discoveryTVResults),
                          ));
                    },
                    child: Text(
                      'All',
                      style: TextStyle(color: KColors.pyellow, fontSize: 17),
                    ))
              ],
            ),
          ),
          FutureBuilder(
            future: discoveryTVResults,
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
                      ? Container(
                          margin: const EdgeInsets.all(8),
                          height: 250,
                          child: ListView.builder(
                            itemCount: (snapshot.data!.results.length > 4)
                                ? (snapshot.data!.results.length -
                                        (snapshot.data!.results.length * 0.5))
                                    .ceil()
                                : snapshot.data!.results.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieScreen(
                                        movieId:
                                            snapshot.data!.results[index].id,
                                        results: Result(
                                            backdropPath: snapshot.data!
                                                .results[index].backdropPath,
                                            posterPath: snapshot.data!
                                                .results[index].posterPath,
                                            adult: snapshot
                                                .data!.results[index].adult,
                                            genreIds: snapshot
                                                .data!.results[index].genreIds,
                                            id: snapshot
                                                .data!.results[index].id,
                                            originalLanguage: snapshot
                                                    .data!
                                                    .results[index]
                                                    .originalLanguage ??
                                                'Unknown',
                                            originalTitle: snapshot.data!
                                                .results[index].originalName!,
                                            overview: snapshot
                                                .data!.results[index].overview!,
                                            popularity: snapshot.data!
                                                .results[index].popularity!,
                                            releaseDate: snapshot.data!
                                                .results[index].firstAirDate!,
                                            title: snapshot.data!.results[index]
                                                .originalName!,
                                            video: false,
                                            voteAverage: snapshot.data!
                                                .results[index].voteAverage!,
                                            voteCount: snapshot.data!
                                                .results[index].voteCount!),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 250,
                                  width: 130,
                                  color: KColors.dark1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: 150,
                                          child: CachedNetworkImage(
                                            imageUrl: (snapshot
                                                        .data!
                                                        .results[index]
                                                        .posterPath !=
                                                    null)
                                                ? 'https://image.tmdb.org/t/p/w500${snapshot.data!.results[index].posterPath}'
                                                : 'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1683318510~exp=1683319110~hmac=f6c70084be88756c84cfac45113e2e261407f4b0b190c546da47bec644dd1238',
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    'assets/images/3828541.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot
                                            .data!.results[index].originalName
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'IMDb',
                                            style: TextStyle(
                                                color: KColors.pyellow),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            snapshot.data!.results[index]
                                                .voteAverage!
                                                .toStringAsFixed(1),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );

                case ConnectionState.waiting:
                  return Container(
                    margin: const EdgeInsets.all(8),
                    height: 250,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
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
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                    )),
                              )),
                        );
                      },
                    ),
                  );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Highest ratings',
                  style: TextStyle(color: KColors.pyellow, fontSize: 17),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllExpansionSeries(
                                keyword: 'Highest ratings',
                                results: topRatedTVResults),
                          ));
                    },
                    child: Text(
                      'All',
                      style: TextStyle(color: KColors.pyellow, fontSize: 17),
                    ))
              ],
            ),
          ),
          FutureBuilder(
            future: topRatedTVResults,
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
                      ? Container(
                          margin: const EdgeInsets.all(8),
                          height: 250,
                          child: ListView.builder(
                            itemCount: (snapshot.data!.results.length > 4)
                                ? (snapshot.data!.results.length -
                                        (snapshot.data!.results.length * 0.5))
                                    .ceil()
                                : snapshot.data!.results.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieScreen(
                                        movieId:
                                            snapshot.data!.results[index].id,
                                        results: Result(
                                            backdropPath: snapshot.data!
                                                .results[index].backdropPath,
                                            posterPath: snapshot.data!
                                                .results[index].posterPath,
                                            adult: snapshot
                                                .data!.results[index].adult,
                                            genreIds: snapshot
                                                .data!.results[index].genreIds,
                                            id: snapshot
                                                .data!.results[index].id,
                                            originalLanguage: snapshot
                                                    .data!
                                                    .results[index]
                                                    .originalLanguage ??
                                                'Unknown',
                                            originalTitle: snapshot.data!
                                                .results[index].originalName!,
                                            overview: snapshot
                                                .data!.results[index].overview!,
                                            popularity: snapshot.data!
                                                .results[index].popularity!,
                                            releaseDate: snapshot.data!
                                                .results[index].firstAirDate!,
                                            title: snapshot.data!.results[index]
                                                .originalName!,
                                            video: false,
                                            voteAverage: snapshot.data!
                                                .results[index].voteAverage!,
                                            voteCount: snapshot.data!
                                                .results[index].voteCount!),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 250,
                                  width: 130,
                                  color: KColors.dark1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: 150,
                                          child: CachedNetworkImage(
                                            imageUrl: (snapshot
                                                        .data!
                                                        .results[index]
                                                        .posterPath !=
                                                    null)
                                                ? 'https://image.tmdb.org/t/p/w500${snapshot.data!.results[index].posterPath}'
                                                : 'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1683318510~exp=1683319110~hmac=f6c70084be88756c84cfac45113e2e261407f4b0b190c546da47bec644dd1238',
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    'assets/images/3828541.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot
                                            .data!.results[index].originalName
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'IMDb',
                                            style: TextStyle(
                                                color: KColors.pyellow),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            snapshot.data!.results[index]
                                                .voteAverage!
                                                .toStringAsFixed(1),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );

                case ConnectionState.waiting:
                  return Container(
                    margin: const EdgeInsets.all(8),
                    height: 250,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
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
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                    )),
                              )),
                        );
                      },
                    ),
                  );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular',
                  style: TextStyle(color: KColors.pyellow, fontSize: 17),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllExpansionSeries(
                              keyword: 'Popular', results: popularTVResults),
                        ));
                  },
                  child: Text(
                    'All',
                    style: TextStyle(color: KColors.pyellow, fontSize: 17),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder(
            future: popularTVResults,
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
                      ? Container(
                          margin: const EdgeInsets.all(8),
                          height: 250,
                          child: ListView.builder(
                            itemCount: (snapshot.data!.results.length > 4)
                                ? (snapshot.data!.results.length -
                                        (snapshot.data!.results.length * 0.5))
                                    .ceil()
                                : snapshot.data!.results.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieScreen(
                                        movieId:
                                            snapshot.data!.results[index].id,
                                        results: Result(
                                            backdropPath: snapshot.data!
                                                .results[index].backdropPath,
                                            posterPath: snapshot.data!
                                                .results[index].posterPath,
                                            adult: snapshot
                                                .data!.results[index].adult,
                                            genreIds: snapshot
                                                .data!.results[index].genreIds,
                                            id: snapshot
                                                .data!.results[index].id,
                                            originalLanguage: snapshot
                                                    .data!
                                                    .results[index]
                                                    .originalLanguage ??
                                                'Unknown',
                                            originalTitle: snapshot.data!
                                                .results[index].originalName!,
                                            overview: snapshot
                                                .data!.results[index].overview!,
                                            popularity: snapshot.data!
                                                .results[index].popularity!,
                                            releaseDate: snapshot.data!
                                                .results[index].firstAirDate!,
                                            title: snapshot.data!.results[index]
                                                .originalName!,
                                            video: false,
                                            voteAverage: snapshot.data!
                                                .results[index].voteAverage!,
                                            voteCount: snapshot.data!
                                                .results[index].voteCount!),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 250,
                                  width: 130,
                                  color: KColors.dark1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: 150,
                                          child: CachedNetworkImage(
                                            imageUrl: (snapshot
                                                        .data!
                                                        .results[index]
                                                        .posterPath !=
                                                    null)
                                                ? 'https://image.tmdb.org/t/p/w500${snapshot.data!.results[index].posterPath}'
                                                : 'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1683318510~exp=1683319110~hmac=f6c70084be88756c84cfac45113e2e261407f4b0b190c546da47bec644dd1238',
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    'assets/images/3828541.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot
                                            .data!.results[index].originalName
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'IMDb',
                                            style: TextStyle(
                                                color: KColors.pyellow),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            snapshot.data!.results[index]
                                                .voteAverage!
                                                .toStringAsFixed(1),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );

                case ConnectionState.waiting:
                  return Container(
                    margin: const EdgeInsets.all(8),
                    height: 250,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
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
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                    )),
                              )),
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
