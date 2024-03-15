import 'package:flutter/material.dart';
import '../../constant/theme/colors.dart';
import '../../models/Song.dart';

class CompositionItem extends StatefulWidget {
  final Song song;

  const CompositionItem({Key? key, required this.song}) : super(key: key);

  @override
  _CompositionItemState createState() => _CompositionItemState();
}

class _CompositionItemState extends State<CompositionItem> {
  bool isPlaying = false;
  Color backgroundColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth * 0.85;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPlaying = !isPlaying;
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        width: itemWidth,

        decoration: BoxDecoration(
          color: isPlaying ? Colors.grey.withOpacity(0.1) : backgroundColor,
          borderRadius: BorderRadius.circular(16.0), // Add BorderRadius here
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: (itemWidth > 275 ? 275 : itemWidth) * 0.25,
              height: (itemWidth > 275 ? 275 : itemWidth) * 0.25,
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
                    child: isPlaying
                        ? IconButton(
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.all(5.0),
                            icon: Image.asset(
                              'assets/images/audio.gif',
                              width: 15.0,
                              height: 15.0,
                            ),
                            onPressed: () {
                              print("nothing");
                            },
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: itemWidth * 0.7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.song.name,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.song.author,
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
            ),
            IconButton(
              onPressed: () {
                print("nothing");
              },
              icon: const Icon(Icons.more_vert, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
