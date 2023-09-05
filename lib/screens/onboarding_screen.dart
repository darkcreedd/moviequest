import 'package:flutter/material.dart';
import 'package:moviequest/screens/signin_screen.dart';
import 'package:moviequest/utils/colors.dart';
import 'package:provider/provider.dart';

import '../statemanagement/dataclass.dart';
import '../statemanagement/models/Series_Models/series_search_results.dart';
import '../statemanagement/models/search_results_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //Movies

  Future<SearchResults?>? discoveryResults;
  Future<SearchResults?>? topRatedResults;
  Future<SearchResults?>? popularResults;

  //Series
  Future<SeriesResult?>? discoveryTVResults;
  Future<SeriesResult?>? topRatedTVResults;
  Future<SeriesResult?>? popularTVResults;
  @override
  @override
  void initState() {
    //Movies
    //Loading everything from the onboarding screen
    discoveryResults =
        Provider.of<DataClass>(context, listen: false).fetchDiscoveries();
    topRatedResults =
        Provider.of<DataClass>(context, listen: false).fetchTopRated();
    popularResults =
        Provider.of<DataClass>(context, listen: false).fetchPopular();
    Provider.of<DataClass>(context, listen: false).mostSearchedResults =
        popularResults;
    //Moving data to statemanagement

    Provider.of<DataClass>(context, listen: false).discoveryResults =
        discoveryResults;
    Provider.of<DataClass>(context, listen: false).topRatedResults =
        topRatedResults;

    Provider.of<DataClass>(context, listen: false).popularResults =
        popularResults;
    Provider.of<DataClass>(context, listen: false).mostSearchedResults =
        popularResults;

    //Series

    //Loading everything from the onboarding screen
    discoveryTVResults =
        Provider.of<DataClass>(context, listen: false).fetchTVDiscoveries();
    topRatedTVResults =
        Provider.of<DataClass>(context, listen: false).fetchTopRatedTV();
    popularTVResults =
        Provider.of<DataClass>(context, listen: false).fetchPopularTV();
    Provider.of<DataClass>(context, listen: false).mostSearchedTVResults =
        popularTVResults;
    //Moving data to statemanagement

    Provider.of<DataClass>(context, listen: false).discoveryTVResults =
        discoveryTVResults;
    Provider.of<DataClass>(context, listen: false).topRatedTVResults =
        topRatedTVResults;

    Provider.of<DataClass>(context, listen: false).popularTVResults =
        popularTVResults;
    Provider.of<DataClass>(context, listen: false).mostSearchedTVResults =
        popularTVResults;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.dark1,
      body: Column(
        children: [
          Expanded(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/onboard_illustration.png'))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                  child: Text(
                    'MOVIE QUEST',
                    style: TextStyle(
                        color: KColors.pyellow,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 50),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: KColors.dblue1,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: const Size(300, 50),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ));
                },
                child: const Text('Get started')),
          ),
        ],
      ),
    );
  }
}
