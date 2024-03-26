import 'package:flutter/material.dart';
import 'package:yt_music/models/MusicVideo.dart';
import '../constant/db_data.dart';
import '../constant/lib_data.dart';
import '../models/Album.dart';
import '../widgets/UI/block_header.dart';
import '../widgets/custom_sliver_app_bar.dart';
import '../widgets/music_tags_bar.dart';
import '../widgets/two_columns_slider.dart';

class LibraryScreen extends StatefulWidget {
  final int selectedDrawer;

  const LibraryScreen({super.key, required this.selectedDrawer});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late final List<Album> albums;
  late final List<MusicVideo> musicVideos;
  late final String userName;

  @override
  void initState() {
    super.initState();
    final List<int> albumsIds = data[0]['albums_id'].cast<int>();
    userName = data[0]['user'];
    albums = AlbumSelector.selectAlbums(data[0], albumsIds);
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (widget.selectedDrawer) {
      case 0:
        content = SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              const CustomSliverAppBar(),
              const MusicTags(data: libData),
              const BlockHeader(
                title: 'Останні дії',
                buttonTitle: "Більше",
              ),
              TwoColumnsSlider(items: albums),
            ],
          ),
        );
        break;
      case 1:
        content = const Center(
          child: Text(
            'Завантаження',
            style: TextStyle(fontSize: 24),
          ),
        );
        break;
      case 2:
        content = const Center(
          child: Text(
            'Файли на пристрої',
            style: TextStyle(fontSize: 24),
          ),
        );
        break;
      default:
        content = const SizedBox.shrink();
    }

    return content;

  }
}
