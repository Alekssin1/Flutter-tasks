typedef Json = Map<String, dynamic>;
class Song {
  final int id;
  final String name;
  final String author;
  final String image;

  Song({
    required this.id,
    required this.name,
    required this.author,
    required this.image,
  });
}

class SongSelector {
  static List<Song> selectSongs(Json data, List<int> songIds) {
    List<Song> selectedSongs = [];
    if (data.containsKey('songs')) {
      List<dynamic> songsData = data['songs'];
      for (var songData in songsData) {
        if (songData.containsKey('id') &&
            songData.containsKey('name') &&
            songData.containsKey('author') &&
            songData.containsKey('image')) {
          int id = songData['id'];
          if (songIds.contains(id)) {
            selectedSongs.add(Song(
              id: id,
              name: songData['name'],
              author: songData['author'],
              image: songData['image'],
            ));
          }
        }
      }
    }
    return selectedSongs;
  }
}

