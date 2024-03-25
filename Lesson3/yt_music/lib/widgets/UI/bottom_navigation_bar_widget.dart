import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/theme/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onDestinationSelected;

  final Map<int, String> labels = {
    0: "Головна",
    1: "Навігація",
    2: "Бібліотека",
  };

 CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

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
        indicatorColor: indicatorColor,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        height: 60,
        destinations: [
          _buildNavItem(
            index: 0,
            icon: SvgPicture.asset(
              'assets/images/home.svg',
              width: 24,
              height: 24,
              color: white,
            ),
            label: "Головна",
            selectedIcon: SvgPicture.asset(
              'assets/images/selected_home.svg',
              width: 24,
              height: 24,
              color: white,
            ),
          ),
          _buildNavItem(
            index: 1,
            icon: SvgPicture.asset(
              'assets/images/navigation.svg',
              width: 24,
              height: 24,
              color: white,
            ),
            label: "Навігація",
            selectedIcon: SvgPicture.asset(
              'assets/images/selected_navigation.svg',
              width: 24,
              height: 24,
              color: white,
            ),
          ),
          _buildNavItem(
            index: 2,
            icon: const Icon(
              Icons.library_music_outlined,
              color: white,
            ),
            label: "Бібліотека",
            selectedIcon: const Icon(
              Icons.library_music,
              color: white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required Widget icon,
    required String label,
    required Widget selectedIcon,
  }) {
    return InkWell(
      onTap: () => onDestinationSelected(index),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            icon,
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: selectedIndex == index ? 150 : 0,
              height: selectedIndex == index ? 150 : 0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            selectedIndex == index
                ? Text(
              labels[index]!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
                : const SizedBox(), // Hide the label when not selected
          ],
        ),
      ),
    );
  }
}