import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MovieCardO extends StatelessWidget {
  const MovieCardO({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        height: 250,
        width: 130,
        color: KColors.dark1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 190,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: const DecorationImage(
                      image: AssetImage('assets/images/queen_mp.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const Text(
              'Queen of the South',
              style: TextStyle(color: Colors.white),
            ),
            Row(
              children: [
                Text(
                  'IMDb',
                  style: TextStyle(color: KColors.pyellow),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '7.8',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
