import 'package:spotify/models/music.dart';

class MusicOperations {
  static List<Music> getMusic() {
    return <Music>[
      Music(
          "Dance Monkey",
          "https://i.scdn.co/image/ab67616d0000b273af9c3770c873ff901f2e7cb2",
          "Dance Monkey by Tones And I",
          "assets/music_1.mp3"),

      Music(
          "Blinding Lights",
          "https://i.scdn.co/image/ab67616d00001e028863bc11d2aa12b54f5aeb36",
          "Blinding Lights by The Weeknd",
          "assets/music_2.mp3"),
      Music(
          "Blinding Lights",
          "https://i.scdn.co/image/ab67616d00001e028863bc11d2aa12b54f5aeb36",
          "Blinding Lights by The Weeknd",
          "assets/music_3.mp3"),
      Music(
          "Blinding Lights",
          "https://i.scdn.co/image/ab67616d00001e028863bc11d2aa12b54f5aeb36",
          "Blinding Lights by The Weeknd",
          "assets/music_1.mp3"),
      Music(
          "Blinding Lights",
          "https://i.scdn.co/image/ab67616d00001e028863bc11d2aa12b54f5aeb36",
          "Blinding Lights by The Weeknd",
          "assets/music_1.mp3"),
      // Add more Music objects as needed
    ];
  }
}
