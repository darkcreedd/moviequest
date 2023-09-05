import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moviequest/statemanagement/models/Series_Models/series_search_results.dart';
import 'package:moviequest/statemanagement/models/search_results_model.dart';
import 'package:moviequest/utils/colors.dart';
import 'package:provider/provider.dart';

import '../statemanagement/dataclass.dart';
import 'movie_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  Future<SearchResults?>? moviesSearchResults;
  Future<SeriesResult?>? seriesSearchResults;

  String? genres;
  bool isMovies = true;

  @override
  void initState() {
    if (Provider.of<DataClass>(context, listen: false).mostSearchedResults !=
        null) {
      moviesSearchResults =
          Provider.of<DataClass>(context, listen: false).mostSearchedResults;
    }
    //  else {
    //   moviesSearchResults =
    //       Provider.of<DataClass>(context, listen: false).mostSearchedResults;
    // }

    if (Provider.of<DataClass>(context, listen: false).mostSearchedTVResults !=
        null) {
      seriesSearchResults =
          Provider.of<DataClass>(context, listen: false).mostSearchedTVResults;
    }
    // else {
    //   seriesSearchResults =
    //       Provider.of<DataClass>(context, listen: false).mostSearchedResults;
    // }
    //Switch future values based on page Index
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataClass>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: KColors.dark1,
        appBar: AppBar(
          backgroundColor: KColors.dark1,
          title: Text(
            'Movie Quest',
            style: TextStyle(color: KColors.pyellow),
          ),
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 120),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: searchController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (value.pageIndexM == 0) {
                              moviesSearchResults =
                                  Provider.of<DataClass>(context, listen: false)
                                      .fetchResults(searchController.text);
                            } else if (value.pageIndexM == 1) {
                              seriesSearchResults =
                                  Provider.of<DataClass>(context, listen: false)
                                      .fetchTVResults(searchController.text);
                            }
                          });
                        },
                        child: const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'What do you want to watch?',
                      hintStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isMovies = !isMovies;
                                value.pageIndexM = 0;
                              });
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: (isMovies)
                                    ? KColors.dblue1
                                    : Colors.grey[600],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  'Movies',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isMovies = !isMovies;
                                value.pageIndexM = 1;
                              });
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: (isMovies)
                                    ? Colors.grey[600]
                                    : KColors.dblue1,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  'Series',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Consumer<DataClass>(
          builder: (context, value, child) => (value.pageIndexM == 0)
              ? FutureBuilder(
                  future: moviesSearchResults,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.results.length,
                          itemBuilder: (context, index) {
                            genres =
                                Provider.of<DataClass>(context, listen: false)
                                    .getGenreNamesByIds(
                                        snapshot.data!.results[index].genreIds);

                            return GestureDetector(
                              //Some code goes here
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieScreen(
                                      movieId: snapshot.data!.results[index].id,
                                      results: snapshot.data!.results[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                height: 200,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      margin: const EdgeInsets.all(4),
                                      height: 190,
                                      width: 135,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: (snapshot.data!.results[index]
                                                    .posterPath !=
                                                null)
                                            ? 'https://image.tmdb.org/t/p/w500${snapshot.data!.results[index].posterPath}'
                                            : 'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1683318510~exp=1683319110~hmac=f6c70084be88756c84cfac45113e2e261407f4b0b190c546da47bec644dd1238',
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                'assets/images/3828541.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data!.results[index]
                                                    .originalTitle
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16.5,
                                                    color: Colors.white),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'IMDb',
                                                    style: TextStyle(
                                                        color: KColors.pyellow,
                                                        fontSize: 16.5),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .results[index]
                                                        .voteAverage
                                                        .toStringAsFixed(1),
                                                    style: const TextStyle(
                                                        fontSize: 16.5,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                snapshot.data!.results[index]
                                                    .releaseDate,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                genres!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  overflow: TextOverflow.fade,
                                                  snapshot.data!.results[index]
                                                      .overview,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                    }
                    return const Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      ),
                    );
                  })
              : FutureBuilder(
                  future: seriesSearchResults,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.results.length,
                          itemBuilder: (context, index) {
                            genres =
                                Provider.of<DataClass>(context, listen: false)
                                    .getGenreNamesByIds(
                                        snapshot.data!.results[index].genreIds);

                            return GestureDetector(
                              //Some code goes here
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieScreen(
                                      movieId: snapshot.data!.results[index].id,
                                      results: Result(
                                          backdropPath: snapshot.data!
                                              .results[index].backdropPath,
                                          posterPath: snapshot
                                              .data!.results[index].posterPath,
                                          adult: snapshot
                                              .data!.results[index].adult,
                                          genreIds: snapshot
                                              .data!.results[index].genreIds,
                                          id: snapshot.data!.results[index].id,
                                          originalLanguage: snapshot
                                                  .data!
                                                  .results[index]
                                                  .originalLanguage ??
                                              'Unknown',
                                          originalTitle: snapshot.data!
                                              .results[index].originalName!,
                                          overview: snapshot
                                              .data!.results[index].overview!,
                                          popularity: snapshot
                                              .data!.results[index].popularity!,
                                          releaseDate: snapshot.data!
                                              .results[index].firstAirDate!,
                                          title: snapshot.data!.results[index]
                                              .originalName!,
                                          video: false,
                                          voteAverage: snapshot.data!
                                              .results[index].voteAverage!,
                                          voteCount: snapshot
                                              .data!.results[index].voteCount!),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                height: 200,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      margin: const EdgeInsets.all(4),
                                      height: 190,
                                      width: 135,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: (snapshot.data!.results[index]
                                                    .posterPath !=
                                                null)
                                            ? 'https://image.tmdb.org/t/p/w500${snapshot.data!.results[index].posterPath}'
                                            : 'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1683318510~exp=1683319110~hmac=f6c70084be88756c84cfac45113e2e261407f4b0b190c546da47bec644dd1238',
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                'assets/images/3828541.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data!.results[index]
                                                    .originalName
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16.5,
                                                    color: Colors.white),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'IMDb',
                                                    style: TextStyle(
                                                        color: KColors.pyellow,
                                                        fontSize: 16.5),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .results[index]
                                                        .voteAverage!
                                                        .toStringAsFixed(1),
                                                    style: const TextStyle(
                                                        fontSize: 16.5,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                snapshot.data!.results[index]
                                                    .firstAirDate!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                genres!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  overflow: TextOverflow.fade,
                                                  snapshot.data!.results[index]
                                                      .overview!,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                    }
                    return const Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
