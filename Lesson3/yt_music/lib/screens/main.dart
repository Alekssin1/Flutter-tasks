import 'package:flutter/material.dart';
import 'package:yt_music/screens/home.dart';
import 'package:yt_music/screens/library.dart';
import '../constant/theme/colors.dart';
import '../widgets/UI/bottom_navigation_bar_widget.dart';
import '../widgets/custom_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedDrawer = 0;
  int pageIndex = 0;
  bool isScrollingUp = true;
  bool isListMode = true;
  final screens = [
    const HomeScreen(),
    const Center(
      child: Text(
        'Навігація',
        style: TextStyle(fontSize: 72),
      ),
    ),
    const LibraryScreen(selectedDrawer: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bottomNavigation,
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
      drawer: pageIndex == 2
          ? CustomDrawer(
              onDrawerItemSelected: (int index) {
                setState(() {
                  selectedDrawer = index;
                  screens[pageIndex] = LibraryScreen(selectedDrawer: index);
                });
              },
              selectedDrawer: selectedDrawer,
            )
          : null,
      floatingActionButton: pageIndex == 2
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: isScrollingUp ? 120.0 : 56.0,
              height: isScrollingUp ? 56.0 : 56.0,
              child: isScrollingUp
                  ? FloatingActionButton.extended(
                      backgroundColor: white,
                      onPressed: () {
                        setState(() {
                          isListMode = !isListMode;
                        });
                      },
                      label: Text(isListMode ? 'List' : 'Grid'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      icon: Icon(
                        isListMode ? Icons.list : Icons.grid_view,
                        color: black,
                        size: 35,
                      ),
                    )
                  : FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          isListMode = !isListMode;
                        });
                      },
                      backgroundColor: white,
                      shape: const CircleBorder(),
                      child: Icon(
                        isListMode ? Icons.list : Icons.grid_view,
                        color: black,
                      ),
                    ),
            )
          : null,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            if (notification.scrollDelta! < 0) {
              if (!isScrollingUp) {
                setState(() {
                  isScrollingUp = true;
                });
              }
            } else {
              if (isScrollingUp) {
                setState(() {
                  isScrollingUp = false;
                });
              }
            }
          }
          return true;
        },
        child: screens[pageIndex],
      ),
    );
  }
}
