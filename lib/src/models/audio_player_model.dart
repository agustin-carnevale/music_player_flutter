import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier{
  bool _playing = false;
  AnimationController _controller;
  Duration _songDuration = Duration(milliseconds: 0);
  Duration _currentPlaceInSong = Duration(milliseconds: 0);

  String get songTotalDuration => printDuration(this._songDuration);
  String get currentSecond => printDuration(this._currentPlaceInSong);

  double get percentage => (this._songDuration.inSeconds == 0.0)? 0: this._currentPlaceInSong.inSeconds / this._songDuration.inSeconds;

  set controller(AnimationController value){
    this._controller=value;
  }
  AnimationController get controller => this._controller;


  bool get playing => this._playing;
  set playing(bool value){
    this._playing = value;
    notifyListeners();
  }

  Duration get songDuration => this._songDuration;
  set songDuration(Duration value){
    this._songDuration = value;
    notifyListeners();
  }

  Duration get currentPlaceInSong => this._currentPlaceInSong;
  set currentPlaceInSong(Duration value){
    this._currentPlaceInSong = value;
    notifyListeners();
  }

  String printDuration(Duration duration){
    String twoDigits(int n){
      if(n>=10) return '$n';
      return '0$n';
    }
    String twoDigitsMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));

    return '$twoDigitsMinutes:$twoDigitsSeconds';
  }

}