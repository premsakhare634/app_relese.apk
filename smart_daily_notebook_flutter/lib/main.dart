import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'app.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await NotificationService.initialize();
  runApp(const SmartDailyNotebookApp());
}
