import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/theme/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final TabController selectedController;
  final void Function(int) onDestinationSelected;

  final Map<int, String> labels = {
    0: "Головна",
    1: "Навігація",
    2: "Бібліотека",
  };

  final List<Widget> icons = [
    SvgPicture.asset(
      'assets/images/home.svg',
      width: 24,
      height: 24,
      color: white,
    ),
    SvgPicture.asset(
      'assets/images/navigation.svg',
      width: 24,
      height: 24,
      color: white,
    ),
    const Icon(
      Icons.library_music_outlined,
      color: white,
    ),
  ];

  final List<Widget> selectedIcons = [
    SvgPicture.asset(
      'assets/images/selected_home.svg',
      width: 24,
      height: 24,
      color: white,
    ),
    SvgPicture.asset(
      'assets/images/selected_navigation.svg',
      width: 24,
      height: 24,
      color: white,
    ),
    const Icon(
      Icons.library_music,
      color: white,
    ),
  ];

  CustomBottomNavigationBar({
    Key? key,
    required this.selectedController,
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
        indicatorColor: Colors.transparent,
        selectedIndex: selectedController.index,
        onDestinationSelected: onDestinationSelected,
        height: 60,
        destinations: List.generate(labels.length, (index) {
          return _buildNavItem(
            index: index,
            label: labels[index]!,
            selected: selectedController.index == index,
          );
        }),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required bool selected,
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
            selected ? selectedIcons[index] : icons[index],
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: selected ? 150 : 0,
              height: selected ? 150 : 0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            selected
                ? Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
