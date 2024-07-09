import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../widgets/custom_task_card.dart';
import 'add_task_screen.dart';
import 'task_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Task Manager',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Colors.amber,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset('assets/todo.png'),
        ),
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
          Obx(() {
            return taskController.taskList.isEmpty
                ? Center(
              child: Text(
                'No tasks for today',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
                : ListView.builder(
              itemCount: taskController.taskList.length,
              itemBuilder: (context, index) {
                final task = taskController.taskList[index];
                return CustomTaskCard(
                  task: task,
                  onTap: () {
                    Get.to(() => TaskDetailsScreen(task: task, index: index));
                  },
                  onCheckboxChanged: (value) {
                    taskController.toggleTaskCompletion(index);
                  },
                );
              },
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Get.to(() => AddTaskScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
