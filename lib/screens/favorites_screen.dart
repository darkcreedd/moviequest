import 'package:flutter/material.dart';
import 'package:moviequest/screens/favorite_series_screen.dart';
import 'package:moviequest/statemanagement/dataclass.dart';
import 'package:moviequest/utils/colors.dart';
import 'package:provider/provider.dart';

import 'favorite_movies_screen.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Widget> page = [const FavoriteMovies(), const FavoriteSeason()];
  bool isMovies = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataClass>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: KColors.dark1,
        appBar: AppBar(
          backgroundColor: KColors.dark1,
          title: const Text('Favorites'),
          centerTitle: true,
          elevation: 0,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: page[value.favoritesPageIndex],
      ),
    );
  }
}
