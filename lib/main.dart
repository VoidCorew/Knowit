import 'package:flutter/material.dart';
import 'package:knowit/services/hive_service.dart';
import 'package:knowit/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  debugPrint("${DateTime.now().millisecond}");

  runApp(const Knowit());
}
