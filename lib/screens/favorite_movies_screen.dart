import 'package:flutter/material.dart';

import '../utils/colors.dart';

class FavoriteMovies extends StatelessWidget {
  const FavoriteMovies({
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
                      image: AssetImage('assets/images/creedIII.jpg'),
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
                      const Text('CREED III',
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      const Text('Drama,War',
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
                              const Text('8.9',
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
                            'After dominating the boxing world, Adonis Creed (Michael B. Jordan) has been thriving in both his career and family life. When childhood friend and former boxing prodigy Damian (Jonathan Majors) resurfaces after serving a long sentence in prison, he is eager to prove that he deserves his shot in the ring. The face off between former friends is more than just a fight. To settle the score, Adonis must put his future on the line to battle Damian--a fighter who has nothing to lose.',
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
