import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviequest/screens/all_expansion.dart';
import 'package:moviequest/screens/movie_screen.dart';
import 'package:moviequest/statemanagement/dataclass.dart';
import 'package:moviequest/statemanagement/models/search_results_model.dart';
import 'package:moviequest/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeScreenMovies extends StatefulWidget {
  const HomeScreenMovies({super.key});

  @override
  State<HomeScreenMovies> createState() => _HomeScreenMoviesState();
}

class _HomeScreenMoviesState extends State<HomeScreenMovies> {
  // ignore: unused_field
  bool isMovies = true;
  Future<SearchResults?>? discoveryResults;
  Future<SearchResults?>? topRatedResults;
  Future<SearchResults?>? popularResults;

  @override
  void initState() {
    //Load everything from the onboarding screen later
    var dataclass = Provider.of<DataClass>(context, listen: false);
    discoveryResults = (dataclass.discoveryResults == null)
        ? discoveryResults = dataclass.fetchDiscoveries()
        : dataclass.discoveryResults;

    topRatedResults = (dataclass.topRatedResults == null)
        ? topRatedResults = dataclass.fetchTopRated()
        : dataclass.topRatedResults;

    popularResults = (dataclass.popularResults == null)
        ? popularResults = dataclass.fetchPopular()
        : dataclass.popularResults;

    dataclass.mostSearchedResults = popularResults;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataClass>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: KColors.dark1,
        body: SingleChildScrollView(
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
                                builder: (context) => AllExpansion(
                                    keyword: 'Discover',
                                    results: discoveryResults),
                              ));
                        },
                        child: Text(
                          'All',
                          style:
                              TextStyle(color: KColors.pyellow, fontSize: 17),
                        ))
                  ],
                ),
              ),
              FutureBuilder(
                future: discoveryResults,
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
                                            (snapshot.data!.results.length *
                                                0.5))
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
                                            movieId: snapshot
                                                .data!.results[index].id,
                                            results:
                                                snapshot.data!.results[index],
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
                                            snapshot.data!.results[index]
                                                .originalTitle
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
                                                    .voteAverage
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
                                builder: (context) => AllExpansion(
                                    keyword: 'Highest ratings',
                                    results: topRatedResults),
                              ));
                        },
                        child: Text(
                          'All',
                          style:
                              TextStyle(color: KColors.pyellow, fontSize: 17),
                        ))
                  ],
                ),
              ),
              FutureBuilder(
                future: topRatedResults,
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
                                            (snapshot.data!.results.length *
                                                0.5))
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
                                            movieId: snapshot
                                                .data!.results[index].id,
                                            results:
                                                snapshot.data!.results[index],
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
                                            snapshot.data!.results[index]
                                                .originalTitle
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
                                                    .voteAverage
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
                              builder: (context) => AllExpansion(
                                  keyword: 'Popular', results: popularResults),
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
                future: popularResults,
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
                                            (snapshot.data!.results.length *
                                                0.5))
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
                                            movieId: snapshot
                                                .data!.results[index].id,
                                            results:
                                                snapshot.data!.results[index],
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
                                            snapshot.data!.results[index]
                                                .originalTitle
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
                                                    .voteAverage
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
        ),
      ),
    );
  }
}
