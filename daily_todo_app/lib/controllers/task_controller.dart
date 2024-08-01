import 'package:get/get.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;

  void addTask(Task task) {
    taskList.add(task);
  }

  void editTask(int index, Task task) {
    taskList[index] = task;
  }

  void deleteTask(int index) {
    taskList.removeAt(index);
  }

  void toggleTaskCompletion(int index) {
    var task = taskList[index];
    task.isCompleted = !task.isCompleted;
    taskList[index] = task;
  }

  void updateTask(int index, Task task) {}
}


// import 'package:get/get.dart';
// import '../models/task.dart';
// import '../services/database_service.dart';
//
// class TaskController extends GetxController {
//   final DatabaseService _databaseService = DatabaseService.instance;
//   var taskList = <Task>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadTasks();
//   }
//
//   void loadTasks() async {
//     final tasks = await _databaseService.getTasks();
//     taskList.assignAll(tasks);
//   }
//
//   void addTask(Task task) {
//     taskList.add(task);
//     _databaseService.addTask(
//       task.title,
//       task.description,
//       task.dueDate.millisecondsSinceEpoch,
//       task.isCompleted ? 1 : 0,
//     );
//   }
//
//   void updateTask(int index, Task task) {
//     taskList[index] = task;
//     _databaseService.updateTask(
//        task.id,
//       task.title,
//       task.description,
//       task.dueDate.millisecondsSinceEpoch,
//       task.isCompleted ? 1 : 0
//     );
//   }
//
//   void toggleTaskCompletion(int index) {
//     final task = taskList[index];
//     final updatedTask = Task(
//       id: task.id,
//       title: task.title,
//       description: task.description,
//       isCompleted: !task.isCompleted,
//       dueDate: task.dueDate,
//     );
//     updateTask(index, updatedTask);
//   }
//
//   void deleteTask(int index) {
//     final task = taskList[index];
//     taskList.removeAt(index);
//     _databaseService.deleteTask(task.id);
//   }
//
//   void changeTaskStatus(int index, bool value) {
//     final task = taskList[index];
//     final updatedTask = Task(
//       id: task.id,
//       title: task.title,
//       description: task.description,
//       isCompleted: value,
//       dueDate: task.dueDate,
//     );
//     updateTask(index, updatedTask);
//   }
// }


// import 'package:get/get.dart';
// import '../models/task.dart';
// import '../services/database_service.dart';
//
// class TaskController extends GetxController {
//   final DatabaseService _databaseService = DatabaseService.instance;
//   var taskList = <Task>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadTasks();
//   }
//
//   void loadTasks() async {
//     final tasks = await _databaseService.getTasks();
//     taskList.assignAll(tasks);
//   }
//
//   void addTask(Task task, {bool scheduleNotification = false}) {
//     taskList.add(task);
//     _databaseService.addTask(
//       task.title,
//       task.description,
//       task.dueDate.millisecondsSinceEpoch,
//       task.isCompleted ? 1 : 0,
//       scheduleNotification,
//     );
//   }
//
//   void updateTask(int index, Task task, {bool scheduleNotification = false}) {
//     taskList[index] = task;
//     _databaseService.updateTask(
//       task.id,
//       task.title,
//       task.description,
//       task.dueDate.millisecondsSinceEpoch,
//       task.isCompleted ? 1 : 0,
//       scheduleNotification,
//     );
//   }
//
//   void toggleTaskCompletion(int index) {
//     final task = taskList[index];
//     final updatedTask = Task(
//       id: task.id,
//       title: task.title,
//       description: task.description,
//       isCompleted: !task.isCompleted,
//       dueDate: task.dueDate, isNotificationScheduled: false,
//     );
//     updateTask(index, updatedTask);
//   }
//
//   void deleteTask(int index) {
//     final task = taskList[index];
//     taskList.removeAt(index);
//     _databaseService.deleteTask(task.id);
//   }
//
//   void changeTaskStatus(int index, bool value) {
//     final task = taskList[index];
//     final updatedTask = Task(
//       id: task.id,
//       title: task.title,
//       description: task.description,
//       isCompleted: value,
//       dueDate: task.dueDate, isNotificationScheduled: null,
//     );
//     updateTask(index, updatedTask);
//   }
// }
//

