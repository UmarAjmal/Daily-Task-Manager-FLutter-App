import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import 'edit_task_screen.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;
  final int index;

  TaskDetailsScreen({required this.task, required this.index});

  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details',
            style: Theme.of(context).textTheme.displayLarge),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Get.to(() => EditTaskScreen(task: task, index: index));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              taskController.deleteTask(index);
              Get.back();
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/todo.png',
                width: 300, // Adjust the width as needed
                height: 300, // Adjust the height as needed
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: ${task.title}',
                    style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 10),
                Text('Description: ${task.description}',
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 10),
                Text('Due Date: ${task.dueDate.toString().split(' ')[0]}',
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
