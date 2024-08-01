import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  final String _taskTableName = "tasks";
  final String tastIDColumnName = "id";
  final String tastContentColumnName = "content";
  final String tastDescriptionColumnName = "description";
  final String tastDatetimeColumnName = "datetime";
  final String tastStatusColumnName = "status";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    try {
      final database = await openDatabase(
        databasePath,
        version: 1,
        onCreate: (db, version) {
          db.execute('''
            CREATE TABLE $_taskTableName (
              $tastIDColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
              $tastContentColumnName TEXT NOT NULL,
              $tastDescriptionColumnName TEXT NOT NULL,
              $tastDatetimeColumnName INTEGER NOT NULL,
              $tastStatusColumnName INTEGER NOT NULL
            )
          ''');
        },
      );
      print('Database created at $databasePath');
      return database;
    } catch (e) {
      print('Error opening database: $e');
      rethrow;
    }
  }

  Future<void> addTask(String title, String description, int datetime, int status) async {
    try {
      final db = await database;
      await db.insert(
        _taskTableName,
        {
          tastContentColumnName: title,
          tastDescriptionColumnName: description,
          tastDatetimeColumnName: datetime,
          tastStatusColumnName: status,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Task added: $title');
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> updateTask(int id, String title, String description, int datetime, int status) async {
    try {
      final db = await database;
      await db.update(
        _taskTableName,
        {
          tastContentColumnName: title,
          tastDescriptionColumnName: description,
          tastDatetimeColumnName: datetime,
          tastStatusColumnName: status,
        },
        where: '$tastIDColumnName = ?',
        whereArgs: [id],
      );
      print('Task updated: $id');
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(_taskTableName);

    return data.map((map) => Task(
      id: map[tastIDColumnName] as int,
      title: map[tastContentColumnName] as String,
      description: map[tastDescriptionColumnName] as String,
      dueDate: DateTime.fromMillisecondsSinceEpoch(map[tastDatetimeColumnName] as int),
      isCompleted: (map[tastStatusColumnName] as int) == 1,
    )).toList();
  }

  Future<void> deleteTask(int id) async {
    try {
      final db = await database;
      await db.delete(
        _taskTableName,
        where: '$tastIDColumnName = ?',
        whereArgs: [id],
      );
      print('Task deleted: $id');
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
//
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import '../models/task.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
//
// class DatabaseService {
//   static Database? _db;
//   static final DatabaseService instance = DatabaseService._constructor();
//   final String _taskTableName = "tasks";
//   final String tastIDColumnName = "id";
//   final String tastContentColumnName = "content";
//   final String tastDescriptionColumnName = "description";
//   final String tastDatetimeColumnName = "datetime";
//   final String tastStatusColumnName = "status";
//   final String tastNotificationScheduledColumnName = "notification_scheduled";
//
//   DatabaseService._constructor();
//
//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await getDatabase();
//     return _db!;
//   }
//
//   Future<Database> getDatabase() async {
//     final databaseDirPath = await getDatabasesPath();
//     final databasePath = join(databaseDirPath, "master_db.db");
//     try {
//       final database = await openDatabase(
//         databasePath,
//         version: 1,
//         onCreate: (db, version) {
//           db.execute('''
//             CREATE TABLE $_taskTableName (
//               $tastIDColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
//               $tastContentColumnName TEXT NOT NULL,
//               $tastDescriptionColumnName TEXT NOT NULL,
//               $tastDatetimeColumnName INTEGER NOT NULL,
//               $tastStatusColumnName INTEGER NOT NULL,
//               $tastNotificationScheduledColumnName INTEGER DEFAULT 0
//             )
//           ''');
//         },
//       );
//       print('Database created at $databasePath');
//       return database;
//     } catch (e) {
//       print('Error opening database: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> addTask(String title, String description, int datetime,
//       int status, bool isNotificationScheduled) async {
//     try {
//       final db = await database;
//       await db.insert(
//         _taskTableName,
//         {
//           tastContentColumnName: title,
//           tastDescriptionColumnName: description,
//           tastDatetimeColumnName: datetime,
//           tastStatusColumnName: status,
//           tastNotificationScheduledColumnName: isNotificationScheduled ? 1 : 0,
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//
//       // Get the inserted task ID
//       final taskId = await db.rawQuery('SELECT last_insert_rowid()');
//       final int id = Sqflite.firstIntValue(taskId) ?? 0;
//
//       // Schedule notification if needed
//       if (isNotificationScheduled) {
//         await AwesomeNotifications().createNotification(
//           content: NotificationContent(
//             id: id,
//             channelKey: 'basic_channel',
//             title: 'Task Due Soon!',
//             body:
//                 'The task "$title" is due on ${DateTime.fromMillisecondsSinceEpoch(datetime).toLocal().toString().split(' ')[0]}.',
//           ),
//           schedule: NotificationCalendar.fromDate(
//               date: DateTime.fromMillisecondsSinceEpoch(datetime)),
//         );
//       }
//       print('Task added: $title');
//     } catch (e) {
//       print('Error adding task: $e');
//     }
//   }
//
//   Future<void> updateTask(int id, String title, String description,
//       int datetime, int status, bool isNotificationScheduled) async {
//     try {
//       final db = await database;
//       await db.update(
//         _taskTableName,
//         {
//           tastContentColumnName: title,
//           tastDescriptionColumnName: description,
//           tastDatetimeColumnName: datetime,
//           tastStatusColumnName: status,
//           tastNotificationScheduledColumnName: isNotificationScheduled ? 1 : 0,
//         },
//         where: '$tastIDColumnName = ?',
//         whereArgs: [id],
//       );
//
//       // Update notification if needed
//       if (isNotificationScheduled) {
//         await AwesomeNotifications().createNotification(
//           content: NotificationContent(
//             id: id,
//             channelKey: 'basic_channel',
//             title: 'Task Due Soon!',
//             body:
//                 'The task "$title" is due on ${DateTime.fromMillisecondsSinceEpoch(datetime).toLocal().toString().split(' ')[0]}.',
//           ),
//           schedule: NotificationCalendar.fromDate(
//               date: DateTime.fromMillisecondsSinceEpoch(datetime)),
//         );
//       } else {
//         // Cancel notification if not scheduled
//         await AwesomeNotifications().cancel(id);
//       }
//       print('Task updated: $id');
//     } catch (e) {
//       print('Error updating task: $e');
//     }
//   }
//
//   Future<List<Task>> getTasks() async {
//     final db = await database;
//     final List<Map<String, dynamic>> data = await db.query(_taskTableName);
//
//     return data
//         .map((map) => Task(
//               id: map[tastIDColumnName] as int,
//               title: map[tastContentColumnName] as String,
//               description: map[tastDescriptionColumnName] as String,
//               dueDate: DateTime.fromMillisecondsSinceEpoch(
//                   map[tastDatetimeColumnName] as int),
//               isCompleted: (map[tastStatusColumnName] as int) == 1,
//             ))
//         .toList();
//   }
//
//   Future<void> deleteTask(int id) async {
//     try {
//       final db = await database;
//       await db.delete(
//         _taskTableName,
//         where: '$tastIDColumnName = ?',
//         whereArgs: [id],
//       );
//
//       // Cancel the notification when deleting a task
//       await AwesomeNotifications().cancel(id);
//
//       print('Task deleted: $id');
//     } catch (e) {
//       print('Error deleting task: $e');
//     }
//   }
// }
