import 'package:flutter/material.dart';
import '../../models/Album.dart';
import '../../models/MusicVideo.dart';
import 'UI/music_video_item.dart';
import 'UI/single_or_album_item.dart';

class SingleRowScroll extends StatelessWidget {
  final List<dynamic> items; // Accepts either Album or MusicVideo list

  const SingleRowScroll({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: EdgeInsets.only(top: 8), // Add padding from the top
          child: Row(
            children: [
              const SizedBox(width: 16), // Adding SizedBox before the Row
              ...items.map((item) {
                if (item is Album) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SingleOrAlbumItem(album: item),
                  );
                } else if (item is MusicVideo) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: MusicVideoItem(musicVideo: item),
                  );
                } else {
                  // Handle unexpected item type
                  return Container(); // Placeholder widget or null
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
