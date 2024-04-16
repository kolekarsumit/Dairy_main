import 'package:flutter/foundation.dart';

class LogoProvider extends ChangeNotifier {
  String? _logo1Path;
  String? _logo2Path;

  String? get logo1Path => _logo1Path;
  String? get logo2Path => _logo2Path;

  void updateLogo1(String path) {
    _logo1Path = path;
    notifyListeners();
  }

  void updateLogo2(String path) {
    _logo2Path = path;
    notifyListeners();
  }
}
