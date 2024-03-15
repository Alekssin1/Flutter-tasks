import 'package:flutter/material.dart';
import '../models/Song.dart';
import 'package:yt_music/widgets/UI/composition_item.dart'; // Import the CompositionItem widget

class FourRowCompositionLists extends StatelessWidget {
  final List<Song> songs;

  const FourRowCompositionLists({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 400.0, // Set the height according to your design
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: (songs.length / 4).ceil(), // Number of columns
          itemBuilder: (context, columnIndex) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(4, (rowIndex) {
                  int index = columnIndex * 4 + rowIndex;
                  if (index < songs.length) {
                    return CompositionItem(
                      song: songs[index],
                    );
                  } else {
                    return const SizedBox(); // Return an empty widget if index exceeds the length of listenAgainSongs
                  }
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
