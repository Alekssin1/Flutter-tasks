import 'package:flutter/material.dart';

import '../constant/theme/colors.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onDrawerItemSelected;
  final int selectedDrawer;

  const CustomDrawer({Key? key, required this.onDrawerItemSelected, required this.selectedDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: appBarBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Material(
              color: appFooterColor,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 24,
                      bottom: 24),
                  child: const Row(
                    children: [
                      Text(
                        'Бібліотека',
                        style: TextStyle(
                          color: white,
                          fontSize: 24,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.library_music),
                  title: Row(
                    children: [
                      const Text(
                        'Бібліотека',
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                        ),
                      ),
                      if (selectedDrawer== 0)
                        const Icon(
                          Icons.check_rounded,
                          color: white,
                        ),
                    ],
                  ),
                  onTap: () {
                    onDrawerItemSelected(0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.download_for_offline_rounded),
                  title: Row(
                    children: [
                      const Text(
                        'Завантаження',
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                        ),
                      ),
                      if (selectedDrawer == 1)
                        const Icon(
                          Icons.check_rounded,
                          color: white,
                        ),
                    ],
                  ),
                  onTap: () {
                    onDrawerItemSelected(1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.mobile_screen_share_rounded),
                  title: Row(
                    children: [
                      const Text(
                        'Файли на пристрої',
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                        ),
                      ),
                      if (selectedDrawer == 2)
                        const Icon(
                          Icons.check_rounded,
                          color: white,
                        ),
                    ],
                  ),
                  onTap: () {
                    onDrawerItemSelected(2);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}