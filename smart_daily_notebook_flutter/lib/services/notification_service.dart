import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final plugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const android=AndroidInitializationSettings('@mipmap/ic_launcher');
    await plugin.initialize(const InitializationSettings(android:android));
    await plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  static Future<void> schedule({required int id,required String title,required String body,required DateTime when}) async {
    if(when.isBefore(DateTime.now())) return;
    await plugin.zonedSchedule(
      id,title,body,tz.TZDateTime.from(when,tz.local),
      const NotificationDetails(android:AndroidNotificationDetails('notebook_reminders','Notebook Reminders',channelDescription:'Personal notebook reminders',importance:Importance.high,priority:Priority.high)),
      androidScheduleMode:AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
  static Future<void> cancel(int id)=>plugin.cancel(id);
}
