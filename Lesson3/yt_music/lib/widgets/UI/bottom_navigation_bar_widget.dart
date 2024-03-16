import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/theme/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onDestinationSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: appBarBackground,
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (Set<MaterialState> states) => const TextStyle(color: white),
        ),
      ),
      child: NavigationBar(
        indicatorColor: const Color(0x00000000),
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        height: 60,
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(
              color: white,
              'assets/images/home.svg',
              width: 24,
              height: 24,
            ),
            label: "Головна",
            selectedIcon: SvgPicture.asset(
              color: white,
              'assets/images/selected_home.svg',
              width: 24,
              height: 24,
            ),
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              color: white,
              'assets/images/navigation.svg',
              width: 24,
              height: 24,
            ),
            label: "Навігація",
            selectedIcon: SvgPicture.asset(
              color: white,
              'assets/images/selected_navigation.svg',
              width: 24,
              height: 24,
            ),
          ),
          const NavigationDestination(
            icon: Icon(
              Icons.library_music_outlined,
              color: white,
            ),
            label: "Бібліотека",
            selectedIcon: Icon(
              Icons.library_music,
              color: white,
            ),
          ),
        ],
      ),
    );
  }
}