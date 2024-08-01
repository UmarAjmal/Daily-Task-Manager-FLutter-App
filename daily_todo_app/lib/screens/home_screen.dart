// import 'package:daily_todo_app/services/database_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/task_controller.dart';
// import '../widgets/custom_task_card.dart';
// import 'add_task_screen.dart';
// import 'task_details_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   final TaskController taskController = Get.put(TaskController());
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Daily Task Manager',
//           style: Theme.of(context).textTheme.displayLarge,
//         ),
//         backgroundColor: Colors.amber,
//         leading: IconButton(
//           onPressed: () {},
//           icon: Image.asset('assets/todo.png'),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: Opacity(
//               opacity: 0.1,
//               child: Image.asset(
//                 'assets/todo.png',
//                 width: 300, // Adjust the width as needed
//                 height: 300, // Adjust the height as needed
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           Obx(() {
//             // Obx: Yeh GetX ka widget hai jo real-time updates dekhata hai.
//             //      Agar task list khali hai toh "No tasks for today" text show karega, warna tasks list banayega.
//             return taskController.taskList.isEmpty
//                 ? Center(
//                     child: Text(
//                       'No tasks for today',
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: taskController.taskList.length,
//                     itemBuilder: (context, index) {
//                       final task = taskController.taskList[index];
//                       return CustomTaskCard(
//                         task: task,
//                         onTap: () {
//                           Get.to(() =>
//                               TaskDetailsScreen(task: task, index: index));
//                         },
//                         onCheckboxChanged: (value) {
//                           taskController.toggleTaskCompletion(index);
//                         },
//                       );
//                     },
//                   );
//           }),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.amber,
//         onPressed: () {
//           Get.to(() => AddTaskScreen());
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../widgets/custom_task_card.dart';
import 'add_task_screen.dart';
import 'task_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController taskController = Get.put(TaskController());
  final ThemeController themeController = Get.put(ThemeController());

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
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Directly open the drawer
          },
          icon: Icon(Icons.menu),
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
                width: 300,
                height: 300,
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
                  onStatusChanged: (value) {
                    task.isCompleted = value;
                    taskController.updateTask(index, task);
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
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text('Settings'),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.amber,
            ),
            ListTile(
              title: Text('Dark Theme'),
              trailing: Obx(() {
                return Switch(
                  value: themeController.isDarkTheme.value,
                  onChanged: (value) {
                    themeController.isDarkTheme.value = value;
                    Get.changeThemeMode(
                        themeController.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeController extends GetxController {
  var isDarkTheme = false.obs;
}





