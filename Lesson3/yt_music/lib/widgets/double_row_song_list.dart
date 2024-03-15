import 'package:flutter/material.dart';
import 'package:yt_music/widgets/UI/listen_again_song_item.dart';
import '../models/Song.dart';

class DoubleRowSongList extends StatelessWidget {
  final List<Song> songs;

  const DoubleRowSongList({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 365.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: (songs.length / 2).ceil(),
          itemBuilder: (context, rowIndex) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      if ((rowIndex * 2) < songs.length)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListenAgainSongItem(
                              song: songs[rowIndex * 2]),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      if ((rowIndex * 2 + 1) < songs.length)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListenAgainSongItem(
                              song: songs[rowIndex * 2 + 1]),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
