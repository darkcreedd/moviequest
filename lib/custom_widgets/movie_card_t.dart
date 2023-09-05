import 'package:flutter/material.dart';
import 'package:moviequest/utils/colors.dart';

class MovieCardT extends StatelessWidget {
  const MovieCardT({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              image: const DecorationImage(
                  image: AssetImage('assets/images/creedIII.jpg'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CREED III',
                      style: TextStyle(fontSize: 16.5, color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          'IMDb',
                          style:
                              TextStyle(color: KColors.pyellow, fontSize: 16.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          '8.2',
                          style: TextStyle(fontSize: 16.5, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Drama, Sports',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    const Expanded(
                      child: Text(
                        overflow: TextOverflow.fade,
                        'After dominating the boxing world, Adonis Creed (Michael B. Jordan) has been thriving in both his career and family life. When childhood friend and former boxing prodigy Damian (Jonathan Majors) resurfaces after serving a long sentence in prison, he is eager to prove that he deserves his shot in the ring. The face off between former friends is more than just a fight. To settle the score, Adonis must put his future on the line to battle Damian--a fighter who has nothing to lose.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
