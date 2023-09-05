import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moviequest/screens/signin_screen.dart';
import 'package:moviequest/utils/colors.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.dark1,
      appBar: AppBar(
        backgroundColor: KColors.dark1,
        title: const Text('Profile'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit_outlined,
              )),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 58,
                backgroundColor: KColors.dark1,
                child: const CircleAvatar(
                  radius: 54,
                  backgroundImage:
                      AssetImage('assets/images/michael_b_jordan.jpeg'),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Darkcreed',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Text(
              'Darkcreedd@gmail.com',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ProfileTiles(
                    icon: FontAwesomeIcons.eye,
                    title: 'Watching now',
                  ),
                  ProfileTiles(
                    icon: Icons.done,
                    title: 'Watched',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ProfileTiles(
                    icon: FontAwesomeIcons.bookmark,
                    title: 'Favorites',
                  ),
                  ProfileTiles(
                    icon: Icons.movie_filter,
                    title: 'Collections',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 70,
                // width: 150,
                decoration: BoxDecoration(
                  color: KColors.lblue1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'My Rated',
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
                  child: const Text('Logout')),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTiles extends StatelessWidget {
  const ProfileTiles({super.key, this.icon, this.title});
  final IconData? icon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        color: KColors.lblue1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.add,
              color: Colors.white,
            ),
            Text(
              title ?? 'Title',
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
