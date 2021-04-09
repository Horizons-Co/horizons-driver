import 'package:audioplayers/audioplayers.dart';

class PlayNotificationSound {
  static AudioPlayer audioPlayer = AudioPlayer();
  static const alert = "https://www.fesliyanstudios.com/play-mp3/4386";

  static playSound()async{
    audioPlayer.onPlayerStateChanged.listen((state)async {
      print("playSound state $state");
      if (state == AudioPlayerState.COMPLETED){
        print("playSound finish");
        await audioPlayer.seek(Duration.zero);
      }
    });
    await audioPlayer.play(alert);
    print("playSound ahmed");
  }

  static stopSound() {
    audioPlayer.stop();
    print("stopSound ahmed");
  }
}
