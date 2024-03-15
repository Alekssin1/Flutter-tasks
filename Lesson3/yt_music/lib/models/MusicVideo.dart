typedef Json = Map<String, dynamic>;

class MusicVideo {
  final int id;
  final String name;
  final String author;
  final String image;
  final String views;

  MusicVideo({
    required this.id,
    required this.name,
    required this.author,
    required this.image,
    required this.views,
  });
}

class MusicVideoSelector {
  static List<MusicVideo> selectMusicVideos(Json data, List<int> musicVideoIds) {
    List<MusicVideo> selectedMusicVideos = [];
    if (data.containsKey('music_videos')) {
      List<dynamic> musicVideosData = data['music_videos'];
      for (var musicVideoData in musicVideosData) {
        if (musicVideoData.containsKey('id') &&
            musicVideoData.containsKey('name') &&
            musicVideoData.containsKey('author') &&
            musicVideoData.containsKey('image') &&
            musicVideoData.containsKey('views')) {
          int id = musicVideoData['id'];
          if (musicVideoIds.contains(id)) {
            selectedMusicVideos.add(MusicVideo(
              id: id,
              name: musicVideoData['name'],
              author: musicVideoData['author'],
              image: musicVideoData['image'],
              views: musicVideoData['views'],
            ));
          }
        }
      }
    }
    return selectedMusicVideos;
  }
}
