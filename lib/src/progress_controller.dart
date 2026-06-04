import 'package:flutter/foundation.dart';

class ProgressController extends ChangeNotifier {
  bool _isPlaying = true;

  bool get isPlaying => _isPlaying;

  void play() {
    if (!_isPlaying) {
      _isPlaying = true;
      notifyListeners();
    }
  }

  void pause() {
    if (_isPlaying) {
      _isPlaying = false;
      notifyListeners();
    }
  }

  void resume() => play();

  void togglePlay() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }
}
