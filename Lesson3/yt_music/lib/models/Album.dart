typedef Json = Map<String, dynamic>;

class Album {
  final int id;
  final String name;
  final String author;
  final String image;
  final String type;

  Album({
    required this.id,
    required this.name,
    required this.author,
    required this.image,
    required this.type,
  });
}

class AlbumSelector {
  static List<Album> selectAlbums(Json data, List<int> albumIds) {
    List<Album> selectedAlbums = [];
    if (data.containsKey('albums')) {
      List<dynamic> albumsData = data['albums'];
      for (var albumData in albumsData) {
        if (albumData.containsKey('id') &&
            albumData.containsKey('name') &&
            albumData.containsKey('author') &&
            albumData.containsKey('image') &&
            albumData.containsKey('type')) {
          int id = albumData['id'];
          if (albumIds.contains(id)) {
            selectedAlbums.add(Album(
              id: id,
              name: albumData['name'],
              author: albumData['author'],
              image: albumData['image'],
              type: albumData['type'],
            ));
          }
        }
      }
    }
    return selectedAlbums;
  }
}
