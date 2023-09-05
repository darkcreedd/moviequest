import 'package:flutter/material.dart';
import 'package:moviequest/screens/MOVIES/home_screen_movies.dart';
import 'package:moviequest/screens/TV_SHOWS/home_screen_series.dart';
import 'package:moviequest/statemanagement/dataclass.dart';
import 'package:moviequest/utils/colors.dart';
import 'package:provider/provider.dart';
import '../statemanagement/models/search_results_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMovies = true;
  Future<SearchResults?>? discoveryResults;
  Future<SearchResults?>? topRatedResults;
  Future<SearchResults?>? popularResults;
  List<Widget> pageSwitch = [
    const HomeScreenMovies(),
    const HomeScreenSeries()
  ];

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
        appBar: AppBar(
          backgroundColor: KColors.dark1,
          title: Text(
            'Movie Quest',
            style: TextStyle(color: KColors.pyellow),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 50),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                            value.pageIndex = 0;
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color:
                                (isMovies) ? KColors.dblue1 : Colors.grey[600],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'Movies',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
                            value.pageIndex = 1;
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color:
                                (isMovies) ? Colors.grey[600] : KColors.dblue1,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'Series',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: pageSwitch[value.pageIndex],
      ),
    );
  }
}
