import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../constant/theme/colors.dart';

class PlayerBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onDestinationSelected;

  const PlayerBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return NavigationBarTheme(
      data: const NavigationBarThemeData(
        backgroundColor: appBarBackground,
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        height: 60,
        destinations: [
          _buildNavItem(
            index: 0,
            label: 'Далі',
          ),
          _buildNavItem(
            index: 1,
            label: 'Текст',
          ),
          _buildNavItem(
            index: 2,
            label: 'Схожі',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
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
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selectedIndex == index
                  ? Icon(
                Icons.album,
                key: UniqueKey(),
                size: 90,
                color: albumBG,
              )
                  : const SizedBox(),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
            ),
            Text(
              label,
              style: const TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
