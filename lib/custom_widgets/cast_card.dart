import 'package:flutter/material.dart';

import '../screens/actor_screen.dart';
import '../utils/colors.dart';

class CastCard extends StatelessWidget {
  const CastCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ActorPage(castId: 855),
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/michael_b_jordan.jpeg'),
                    fit: BoxFit.cover),
              ),
            )),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                'Michael B. Jordan',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 0, 4, 4),
              child: Text(
                'Adonis Creed',
                style: TextStyle(color: KColors.pyellow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
