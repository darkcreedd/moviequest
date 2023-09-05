import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moviequest/statemanagement/dataclass.dart';
import 'package:moviequest/utils/colors.dart';
import 'package:provider/provider.dart';

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataClass>(
      builder: (context, dvalue, child) => BottomNavigationBar(
        onTap: (value) {
          dvalue.pageIndex = value;
          Navigator.pushReplacementNamed(context, '/main');
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
    );
  }
}
