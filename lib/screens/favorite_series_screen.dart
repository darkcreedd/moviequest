import 'package:flutter/material.dart';

import '../utils/colors.dart';

class FavoriteSeason extends StatelessWidget {
  const FavoriteSeason({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            height: 200,
            color: KColors.dark1,
            child: Row(children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 200,
                width: 130,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/images/vikings.jpg'),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Vikings',
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      const Text('Historical Drama, Action, War',
                          style: TextStyle(color: Colors.white)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('IDMb',
                                  style: TextStyle(color: KColors.pyellow)),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('8.5',
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              splashRadius: 20,
                              icon: const Icon(
                                Icons.bookmark_outline,
                                color: Colors.red,
                              ))
                        ],
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 1.0),
                          child: Text(
                            overflow: TextOverflow.fade,
                            'Ragnar Lothbrok, a legendary Norse hero, is a mere farmer who rises up to become a fearless warrior and commander of the Viking tribes with the support of his equally ferocious family.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
