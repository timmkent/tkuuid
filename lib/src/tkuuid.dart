import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class TKUUID {
  static final TKUUID _singleton = TKUUID._internal();
  TKUUID._internal();
  factory TKUUID() {
    return _singleton;
  }
  SharedPreferences? shared;
  String? _tkuuid;
  bool? _isrestart;

  static initialize() async {
    final shared = await SharedPreferences.getInstance();
    final savedTKUUID = shared.getString('tkUUID');
    if (savedTKUUID == null) {
      final tkUUID = const Uuid().v1();
      shared.setString('tkUUID', tkUUID);
      _singleton._tkuuid = tkUUID;
      _singleton._isrestart = true;
    } else {
      _singleton._tkuuid = savedTKUUID;
      _singleton._isrestart = false;
    }
  }

  static String get tkuuid {
    assert(_singleton._tkuuid != null, "TKUUID not initialized.");
    return _singleton._tkuuid!;
  }

  static bool get isRestart {
    assert(_singleton._isrestart != null, "TKUUID not initialized.");
    return _singleton._isrestart!;
  }
}
