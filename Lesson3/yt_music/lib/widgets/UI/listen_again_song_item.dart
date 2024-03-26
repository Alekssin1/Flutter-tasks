import 'package:flutter/material.dart';
import '../../constant/theme/colors.dart';
import '../../models/Song.dart';
import '../music_player.dart';

class ListenAgainSongItem extends StatefulWidget {
  final Song song;

  const ListenAgainSongItem({super.key, required this.song});

  @override
  _ListenAgainSongItemState createState() => _ListenAgainSongItemState();
}

class _ListenAgainSongItemState extends State<ListenAgainSongItem> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.25;
    return SizedBox(
      width: imageWidth > 130 ? 130 : imageWidth,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: widget.song.id,
            child: Container(
              width: imageWidth > 100 ? 100 : imageWidth,
              height: imageWidth > 100 ? 100 : imageWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(widget.song.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        size: (imageWidth > 100 ? 100 : imageWidth) * 0.33,
                        color: white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicPlayer(song: widget.song),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: imageWidth > 100 ? 100 : imageWidth,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Icon(Icons.check_circle, color: Colors.grey, size: 14),
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: widget.song.name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
