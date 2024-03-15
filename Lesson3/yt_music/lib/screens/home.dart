import 'package:flutter/material.dart';
import '../constant/db_data.dart';
import '../constant/theme/colors.dart';
import '../models/Album.dart';
import '../models/Song.dart';
import '../widgets/UI/block_header.dart';
import '../widgets/custom_sliver_app_bar.dart';
import '../widgets/double_row_song_list.dart';
import '../widgets/music_tags_bar.dart';
import '../widgets/four_row_composition_lists.dart';
import '../widgets/single_row_album_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Song sampleSong;
  late final List<Song> listenAgainSongs;
  late final List<Song> fastChoiceSongs;
  late final List<Song> coverVersionsSongs;
  late final List<Album> albums;
  late final String userName;


  @override
  void initState() {
    super.initState();
    final List<int> listenAgainSongIds = data[0]['listen_again'].cast<int>();
    final List<int> fastChoiceSongIds = data[0]['fast_choice'].cast<int>();
    final List<int> coverVersionsSongIds = data[0]['cover_versions'].cast<int>();
    final List<int> albumsIds = data[0]['albums_id'].cast<int>();
    userName = data[0]['user'];
    listenAgainSongs =
        SongSelector.selectSongs(data[0], listenAgainSongIds);
    fastChoiceSongs =
        SongSelector.selectSongs(data[0], fastChoiceSongIds);
    coverVersionsSongs =
        SongSelector.selectSongs(data[0], coverVersionsSongIds);
    albums = AlbumSelector.selectAlbums(data[0], albumsIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const CustomSliverAppBar(),
            const MusicTags(data: data),
            BlockHeader(
              title: 'Послухати ще раз',
              beforeTitle: userName,
              buttonTitle: "Більше",
            ),
            DoubleRowSongList(songs: listenAgainSongs),
            const BlockHeader(
              title: 'Швидкий вибір',
              beforeTitle: "СТВОРІТЬ РАДІОСТАНЦІЮ НА ОСНОВІ КОМПОЗИЦІЇ",
              buttonTitle: "Відворити все",
            ),
            FourRowCompositionLists(songs: fastChoiceSongs),
            const BlockHeader(
              title: 'Кавер-версії та ремікси',
              buttonTitle: "Відворити все",
            ),
            FourRowCompositionLists(songs: coverVersionsSongs),
            const BlockHeader(
              title: 'Новинки',
              buttonTitle: "Більше",
            ),
            SingleRowAlbumScroll(albums: albums),
          ],
        ),
      ),
    );
  }

}


