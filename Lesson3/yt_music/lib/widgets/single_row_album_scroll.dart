import 'package:flutter/material.dart';
import '../../constant/theme/colors.dart';
import '../../models/Album.dart';
import 'UI/single_or_album_item.dart';

class SingleRowAlbumScroll extends StatelessWidget {
  final List<Album> albums;

  SingleRowAlbumScroll({Key? key, required this.albums}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 16), // Adding SizedBox before the Row
            ...albums.map((album) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SingleOrAlbumItem(album: album),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
