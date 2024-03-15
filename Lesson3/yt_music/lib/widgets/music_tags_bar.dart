import 'package:flutter/material.dart';
import 'package:yt_music/widgets/UI/tag_button.dart';
import '../constant/theme/colors.dart';

class MusicTags extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const MusicTags({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _FixedButtonsDelegate(
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: appBarBackground,
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 1.0,
              ),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16.0),
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (data[index].containsKey('tags')) {
                List<dynamic> tags = data[index]['tags'];
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ButtonWidget(tags[0].toString()),
                    ),
                    for (var i = 1; i < tags.length; i++)
                      Container(
                        margin: EdgeInsets.only(
                            right: i == tags.length - 1 ? 0 : 8.0),
                        child: ButtonWidget(tags[i].toString()),
                      ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _FixedButtonsDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _FixedButtonsDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}