import 'package:flutter/material.dart';
import '../../constant/theme/colors.dart';
import '../../models/MusicVideo.dart';

class MusicVideoItem extends StatefulWidget {
  final MusicVideo musicVideo;

  const MusicVideoItem({Key? key, required this.musicVideo}) : super(key: key);

  @override
  _MusicVideoItemState createState() => _MusicVideoItemState();
}

class _MusicVideoItemState extends State<MusicVideoItem> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.8;
    return SizedBox(
      width: imageWidth > 370 ? 370 : imageWidth,
      height: 300,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isPlaying = !isPlaying;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: imageWidth > 355 ? 355 : imageWidth,
                  height: imageWidth > 355 ? 200 : imageWidth * 0.5625,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    image: DecorationImage(
                      image: AssetImage(widget.musicVideo.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                if (isPlaying)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'assets/images/audio.gif',
                        width: 30.0,
                        height: 30.0,
                      ),
                    ),
                  ),
                if (!isPlaying)
                  Positioned.fill(
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.play_circle_filled,
                          size: 50,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: imageWidth > 355 ? 355 : imageWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.musicVideo.name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.musicVideo.author} • ${widget.musicVideo.views}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
