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
