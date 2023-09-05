import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviequest/screens/movie_screen.dart';
import '../custom_widgets/general_bottom_navigation_bar.dart';
import '../statemanagement/models/search_results_model.dart';

import '../utils/colors.dart';

class AllExpansion extends StatefulWidget {
  const AllExpansion({super.key, required this.keyword, this.results});
  final String keyword;
  final Future<SearchResults?>? results;

  @override
  State<AllExpansion> createState() => _AllExpansionState();
}

class _AllExpansionState extends State<AllExpansion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.dark1,
      appBar: AppBar(
        backgroundColor: KColors.dark1,
        title: Text(widget.keyword),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: FutureBuilder(
            future: widget.results,
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
                          child: GridView.builder(
                            padding: const EdgeInsets.all(10.0),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 170,
                                    mainAxisExtent: 245,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemCount: snapshot.data!.results.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieScreen(
                                          movieId:
                                              snapshot.data!.results[index].id,
                                          results:
                                              snapshot.data!.results[index],
                                        ),
                                      ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        width: 150,
                                        child: CachedNetworkImage(
                                          imageUrl: (snapshot
                                                      .data!
                                                      .results[index]
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
                                    ),
                                    Text(
                                      snapshot
                                          .data!.results[index].originalTitle,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'IMDb',
                                          style:
                                              TextStyle(color: KColors.pyellow),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot
                                              .data!.results[index].voteAverage
                                              .toStringAsFixed(1),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
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
                  return const Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: const MainBottomNavBar(),
    );
  }
}
