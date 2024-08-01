import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart'; // Import awesome_notifications
import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../services/database_service.dart';
import '../widgets/custom_input_field.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  final int index;

  EditTaskScreen({required this.task, required this.index});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final DatabaseService _databaseService = DatabaseService.instance;
  final TaskController taskController = Get.find();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime dueDate;
  // bool isNotificationScheduled = true; // Default to true if notifications are enabled

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
    dueDate = widget.task.dueDate;
    // Set notification status based on task
    // isNotificationScheduled = widget.task.isNotificationScheduled ?? true;
  }

  Future<void> scheduleNotification(DateTime dateTime) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: widget.task.id, // Use the task's ID for unique notifications
        channelKey: 'basic_channel', // Channel key defined in main.dart
        title: 'Task Due Soon!',
        body: 'The task "${titleController.text}" is due on ${dateTime.toLocal().toString().split(' ')[0]}.',
      ),
      schedule: NotificationCalendar(
        year: dateTime.year,
        month: dateTime.month,
        day: dateTime.day,
        hour: dateTime.hour,
        minute: dateTime.minute,
        second: dateTime.second,
        millisecond: dateTime.millisecond,
        preciseAlarm: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Task',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Colors.amber,
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomInputField(
                  controller: titleController,
                  labelText: 'Title',
                  borderColor: Colors.black,
                  cursorColor: Colors.black,
                ),
                SizedBox(height: 10),
                CustomInputField(
                  controller: descriptionController,
                  labelText: 'Description',
                  borderColor: Colors.black,
                  cursorColor: Colors.black,
                ),
                ListTile(
                  title: Text('Due Date: ${dueDate.toString().split(' ')[0]}'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: dueDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Colors.black,
                            hintColor: Colors.black,
                            colorScheme: const ColorScheme.light(primary: Colors.black),
                            buttonTheme: const ButtonThemeData(
                              textTheme: ButtonTextTheme.primary,
                            ),
                            dialogBackgroundColor: Colors.amber,
                            textTheme: const TextTheme(
                              headlineMedium: TextStyle(color: Colors.black),
                              titleMedium: TextStyle(color: Colors.black),
                              bodyMedium: TextStyle(color: Colors.black),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      setState(() {
                        dueDate = pickedDate;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      // Prepare updated task details
                      final updatedTitle = titleController.text;
                      final updatedDescription = descriptionController.text;
                      final updatedDueDate = dueDate;
                      final updatedStatus = widget.task.isCompleted ? 1 : 0;

                      // Update the task in the TaskController
                      final updatedTask = Task(
                        id: widget.task.id,
                        title: updatedTitle,
                        description: updatedDescription,
                        isCompleted: widget.task.isCompleted,
                        dueDate: updatedDueDate,
                        // isNotificationScheduled: isNotificationScheduled, // Add this field if you have it in your Task model
                      );
                      taskController.updateTask(widget.index, updatedTask);

                      // Update the task in the database
                      await _databaseService.updateTask(
                        widget.task.id, // The ID of the task to update
                        updatedTitle,
                        updatedDescription,
                        updatedDueDate.millisecondsSinceEpoch,
                        updatedStatus,
                        // (isNotificationScheduled ? 1 : 0) as bool,
                      );

                      // Schedule a notification for the updated due date
                      // if (isNotificationScheduled) {
                      //   await scheduleNotification(dueDate);
                      // }

                      // Go back to the previous screen
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.amber,
                    shadowColor: Colors.black,
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
