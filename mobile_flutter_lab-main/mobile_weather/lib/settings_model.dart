import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class F {
  final bool temp;
  final bool speed;
  final bool pressure;

  F(this.temp, this.speed, this.pressure);

  F.fromPrefs(SharedPreferences prefs)
      : temp = prefs.getString('temp_unit') == 'C' ? true : false,
        speed = prefs.getString('speed_unit') == 'm_c' ? true : false,
        pressure = prefs.getString('pressure_unit') == 'hpa' ? true : false;

  void save(SharedPreferences prefs) {
    prefs.setString('temp_unit', temp ? 'C' : 'F');
    prefs.setString('speed_unit', speed ? 'm_c' : 'km_h');
    prefs.setString('pressure_unit', pressure ? 'hpa' : 'mm_hg');
  }

}

class SettingsModel extends ChangeNotifier {
  static late final SharedPreferences prefs;
  var _units = F(true, true, true);

  SettingsModel() : _units = F.fromPrefs(prefs);

  F get units => _units;
  set units(F units) {
    _units = units;
    _units.save(prefs);
    notifyListeners();
  }

  static Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    var user = prefs.getString("Username");
    if (user != null && user.isNotEmpty) {
      // ignore: avoid_print
      print("fffffffff");
    }
  }
  String formatTemp(double temperatureC) {
    if (_units.temp) {
      return '${temperatureC.round()}˚C';
    } else {
      return '${(temperatureC * 9 / 5 + 32).round()}˚F';
    }
  }

  String formatSpeed(double speedMs) {
    if (_units.speed) {
      return '$speedMs м/с';
    } else {
      return '${(speedMs * 3.6).round()} м/с';
    }
  }

  String formatPressure(int pressureHPa) {
    if (_units.pressure) {
      return '$pressureHPa гПа';
    } else {
      return '${(pressureHPa / 1.333).round()} мм.рт.ст.';
    }
  }
}
