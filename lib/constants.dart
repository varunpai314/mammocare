import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static String baseUrl = 'http://192.168.29.76:3000';

  static var token = SharedPreferences.getInstance().then((prefs) {
    return prefs.getString('token');
  });
  //http://192.168.29.76:3000
  //
}
