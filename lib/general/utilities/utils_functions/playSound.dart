import 'package:audioplayers/audioplayers.dart';

class PlayNotificationSound {
  static AudioPlayer audioPlayer = AudioPlayer();
  static const alert = "https://www.fesliyanstudios.com/play-mp3/4386";

  static playSound()async{
    audioPlayer.setUrl(alert);
    await audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    audioPlayer.resume();
  }

  static stopSound()async{
    await audioPlayer.release();
  }
}
