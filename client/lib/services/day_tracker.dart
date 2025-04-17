import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class DayTrackerService {
  static const String _lastRunKey = 'last_app_run';
  static const String _dateFormat = 'yyyy-MM-dd';

  Future<bool> isNewDay() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat(_dateFormat).format(DateTime.now());
    final lastRun = prefs.getString(_lastRunKey);

    if (lastRun != today) {
      await update();
    }

    return lastRun != today;
  }

  Future<void> update() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat(_dateFormat).format(DateTime.now());
    await prefs.setString(_lastRunKey, today);
  }
}
