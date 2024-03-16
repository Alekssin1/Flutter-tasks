import 'package:flutter/material.dart';
import '../models/Song.dart';
import 'package:yt_music/widgets/UI/composition_item.dart';

class FourRowCompositionLists extends StatelessWidget {
  final List<Song> songs;

  const FourRowCompositionLists({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 350.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: (songs.length / 4).ceil(),
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
                    return const SizedBox();
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
