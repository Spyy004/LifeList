import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

int daysBetween(DateTime froms, DateTime to) {
  froms = DateTime(froms.year, froms.month, froms.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(froms).inHours / 24).round();
}

tz.TZDateTime getNotificationScheduleTime(DateTime deadline, bool isCompleted) {
  final timeZoneName = tz.TimeZone.UTC.abbreviation;
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
  tz.Location location = tz.getLocation(timeZoneName);
  final scheduledDate = tz.TZDateTime.from(deadline, location);
  tz.TZDateTime timeToNotify = isCompleted
      ? scheduledDate.add(const Duration(hours: 23))
      : scheduledDate.subtract(const Duration(hours: 1));
  return timeToNotify;
}
