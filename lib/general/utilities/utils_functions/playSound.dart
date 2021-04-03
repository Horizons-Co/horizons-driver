import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayNotificationSound {
  static AudioPlayer audioPlayer = AudioPlayer();
  static AudioCache audioCache = AudioCache(fixedPlayer: audioPlayer);

  static playSound() {
    audioCache.play(
      "notification.mp3",
    );
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == AudioPlayerState.COMPLETED) {
        audioCache.play(
          "notification.mp3",
        );
      }
    });
    print("playSound ahmed");
  }

  static stopSound() {
    audioPlayer.stop();
    print("stopSound ahmed");
  }
}
