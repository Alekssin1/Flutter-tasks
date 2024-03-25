import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../constant/theme/colors.dart';
import 'package:palette_generator/palette_generator.dart';
import '../models/Song.dart';
import 'UI/PlayerBottomNavigationBar.dart';

class MusicPlayer extends StatefulWidget {
  final Song song;

  const MusicPlayer({Key? key, required this.song}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  int pageIndex = 0;
  List<bool> isSelected = [true, false];
  late PaletteGenerator _paletteGenerator;
  bool _isLoadingPalette = true;

  @override
  void initState() {
    super.initState();
    _generatePalette();
  }

  void _generatePalette() async {
    setState(() {
      _isLoadingPalette = true;
    });

    final imageProvider = AssetImage(widget.song.image);

    _paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);

    setState(() {
      _isLoadingPalette = false;
    });
  }

  void _handleCollapse() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isLoadingPalette
          ? bottomNavigation
          : _paletteGenerator.dominantColor!.color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          color: navigationMusic,
          onPressed: _handleCollapse,
        ),
        title: Center(
          child: ToggleButtons(
            isSelected: isSelected,
            onPressed: (int index) {
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < isSelected.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
              });
            },
            children: const <Widget>[
              Text(
                "Пісня",
                style: TextStyle(color: playerToggleButtons),
              ),
              Text(
                "Відео",
                style: TextStyle(color: playerToggleButtons),
              ),
            ],
          ),
        ),
      ),
      body: Hero(
        tag: widget.song.id,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9, // Adjust height as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width > 550 ? 220 : MediaQuery.of(context).size.width * 1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.song.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: PlayerBottomNavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }
}

