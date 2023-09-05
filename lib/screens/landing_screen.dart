import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moviequest/screens/favorites_screen.dart';
import 'package:moviequest/screens/home_screen.dart';
import 'package:moviequest/screens/search_screen.dart';
import 'package:moviequest/screens/user_profile_screen.dart';
import 'package:moviequest/utils/colors.dart';
import 'package:provider/provider.dart';

import '../statemanagement/dataclass.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Widget> body = [
    const HomePage(),
    const SearchPage(),
    const FavoritesPage(),
    const UserProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<DataClass>(
      builder: (context, dvalue, child) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 15, 24),
        body: body[dvalue.pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              dvalue.pageIndex = value;
            });
          },
          currentIndex: dvalue.pageIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: KColors.pyellow,
          unselectedItemColor: KColors.paleyellow,
          backgroundColor: KColors.dark1,
          items: [
            BottomNavigationBarItem(
                icon: SizedBox(
                  height: 25,
                  child: Image.asset(
                    'assets/images/home_icon.png',
                    color: KColors.pyellow,
                    scale: 0.5,
                  ),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: KColors.pyellow,
                size: 21,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.star_border_outlined,
                  color: KColors.pyellow,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SizedBox(
                  height: 25,
                  child: Image.asset(
                    'assets/images/user_icon.png',
                    color: KColors.pyellow,
                  ),
                ),
                label: 'Home'),
          ],
        ),
      ),
    );
  }
}
