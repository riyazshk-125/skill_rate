import 'package:get_storage/get_storage.dart';

class Prefs {
  late GetStorage _storage;

  final String _USER_TOKEN_KEY = "userTokenKey";
  final String _ON_BOARD_SCREEN = "onBoard";

  Prefs() {
    _storage = GetStorage();
  }

  Future<void> setUserToken(String token) async {
    return _storage.write(_USER_TOKEN_KEY, token);
  }

  Future<String> getUserToken() async {
    return _storage.read<String>(_USER_TOKEN_KEY) ?? "";
  }

  Future<void> clearUser() async {
    _storage.remove(_USER_TOKEN_KEY);
  }

  Future<void> setOnBoard(bool isShown) async {
    return _storage.write(_ON_BOARD_SCREEN, isShown);
  }

  Future<bool> getOnBoard() async {
    return _storage.read<bool>(_ON_BOARD_SCREEN) ?? false;
  }

  Future<void> clearOnBoard() async {
    _storage.remove(_ON_BOARD_SCREEN);
  }
}
