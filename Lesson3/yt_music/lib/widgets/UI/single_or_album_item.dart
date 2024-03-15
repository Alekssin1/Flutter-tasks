import 'package:flutter/material.dart';
import '../../constant/theme/colors.dart';
import '../../models/Album.dart';

class SingleOrAlbumItem extends StatefulWidget {
  final Album album;

  const SingleOrAlbumItem({Key? key, required this.album}) : super(key: key);

  @override
  _SingleOrAlbumItemState createState() => _SingleOrAlbumItemState();

  // Expose a method to get the state type
  static _SingleOrAlbumItemState? of(BuildContext context) =>
      context.findAncestorStateOfType<_SingleOrAlbumItemState>();
}

class _SingleOrAlbumItemState extends State<SingleOrAlbumItem> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.4;
    return SizedBox(
      width: imageWidth > 250 ? 250 : imageWidth,
      height: 275,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: imageWidth > 200 ? 200 : imageWidth,
            height: imageWidth > 200 ? 200 : imageWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              image: DecorationImage(
                image: AssetImage(widget.album.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: imageWidth > 200 ? 200 : imageWidth,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.album.name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: '${widget.album.type} • ${widget.album.author}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
