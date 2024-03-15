import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constant/theme/colors.dart';

class CustomSliverAppBar extends StatefulWidget {
  const CustomSliverAppBar({super.key});

  @override
  CustomSliverAppBarState createState() => CustomSliverAppBarState();
}

class CustomSliverAppBarState extends State<CustomSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      expandedHeight: 64.0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/Youtube_Music_logo_dark.svg',
            width: 80,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
        ],
      ),
      backgroundColor: appBarBackground,
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.search),
          iconSize: 24.0,
          color: Colors.white,
          onPressed: () => print('search'),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: ClipOval(
            child: Image.asset(
              'assets/images/db/avatar.jpg',
              width: 28.0,
              height: 28.0,
            ),
          ),
          onPressed: () => print('user'),
        )
      ],
    );
  }
}
