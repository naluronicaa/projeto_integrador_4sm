import 'package:shared_preferences/shared_preferences.dart';

Future<void> setPopupExibido(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('popup_exibido', value);
}

Future<bool> obterPopupExibido() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('popup_exibido') ?? false;
}
