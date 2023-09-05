import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviequest/custom_widgets/general_bottom_navigation_bar.dart';
import 'package:moviequest/statemanagement/models/Series_Models/credits_results_model_series.dart';

import '../statemanagement/models/credits_results_model.dart';
import '../utils/colors.dart';
import 'actor_screen.dart';

// ignore: must_be_immutable
class AllCastAndCrewExpansion extends StatefulWidget {
  AllCastAndCrewExpansion(
      {super.key, required this.keyword, required this.results});
  String keyword;
  List<Cast> results;

  @override
  State<AllCastAndCrewExpansion> createState() =>
      _AllCastAndCrewExpansionState();
}

class _AllCastAndCrewExpansionState extends State<AllCastAndCrewExpansion> {
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
          child: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 170,
                mainAxisExtent: 245,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: widget.results.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ActorPage(castId: widget.results[index].id),
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 220,
                  width: 130,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: (widget.results[index].profilePath != null)
                              ? 'https://image.tmdb.org/t/p/w500${widget.results[index].profilePath}'
                              : 'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1683318510~exp=1683319110~hmac=f6c70084be88756c84cfac45113e2e261407f4b0b190c546da47bec644dd1238',
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/3828541.jpg'),
                          fit: BoxFit.cover,
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.results[index].originalName,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 0, 4, 4),
                        child: Text(
                          widget.results[index].character ?? 'Unknown',
                          style: TextStyle(color: KColors.pyellow),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const MainBottomNavBar(),
    );
  }
}

class AllCastAndCrewExpansionSeries extends StatefulWidget {
  const AllCastAndCrewExpansionSeries(
      {super.key, required this.keyword, required this.results});
  final String keyword;
  final List<Casts> results;

  @override
  State<AllCastAndCrewExpansionSeries> createState() =>
      _AllCastAndCrewExpansionSeriesState();
}

class _AllCastAndCrewExpansionSeriesState
    extends State<AllCastAndCrewExpansionSeries> {
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
          child: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 170,
                mainAxisExtent: 245,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: widget.results.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ActorPage(castId: widget.results[index].id),
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 220,
                  width: 130,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: (widget.results[index].profilePath != null)
                              ? 'https://image.tmdb.org/t/p/w500${widget.results[index].profilePath}'
                              : 'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1683318510~exp=1683319110~hmac=f6c70084be88756c84cfac45113e2e261407f4b0b190c546da47bec644dd1238',
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/3828541.jpg'),
                          fit: BoxFit.cover,
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.results[index].originalName,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 0, 4, 4),
                        child: Text(
                          widget.results[index].character,
                          style: TextStyle(color: KColors.pyellow),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const MainBottomNavBar(),
    );
  }
}
