import 'package:flutter/material.dart';
import '../../models/Album.dart';
import '../../models/MusicVideo.dart';
import 'UI/music_video_item.dart';
import 'UI/single_or_album_item.dart';

class TwoColumnsSlider extends StatelessWidget {
  final List<dynamic> items;

  const TwoColumnsSlider({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              _calculateCrossAxisCount(MediaQuery.of(context).orientation),
          crossAxisSpacing: 4,
          mainAxisSpacing: 0,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final item = items[index];
            if (item is Album) {
              return SingleOrAlbumItem(album: item);
            } else if (item is MusicVideo) {
              return MusicVideoItem(musicVideo: item);
            } else {
              return Container();
            }
          },
          childCount: items.length,
        ),
      ),
    );
  }

  int _calculateCrossAxisCount(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      return 4;
    } else {
      return 2;
    }
  }
}
