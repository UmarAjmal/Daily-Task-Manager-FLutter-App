import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:daily_todo_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';

void main() async
{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ),
      themeMode: ThemeMode.system,
      // ThemeMode.system ke bajaye aap apne preference ke according light, dark, ya system set kar sakte hain.
      home: SplashScreen(),
    );
  }
}

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:daily_todo_app/screens/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure initialization
//   await AwesomeNotifications().initialize(
//     'resource://drawable/res_app_icon',
//     [
//       NotificationChannel(
//         channelKey: 'basic_channel',
//         channelName: 'Basic notifications',
//         channelDescription: 'Notification channel for basic tests',
//         defaultColor: Colors.amber,
//         ledColor: Colors.white,
//       )
//     ],
//   );
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Daily Task Manager',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         textTheme: const TextTheme(
//           displayLarge: TextStyle(
//               fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//           bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
//         ),
//       ),
//       themeMode: ThemeMode.system,
//       home: SplashScreen(),
//     );
//   }
// }
//
