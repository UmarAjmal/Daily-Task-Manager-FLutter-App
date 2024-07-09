import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../widgets/custom_input_field.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController taskController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? dueDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
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
                width: 300, // Adjust the width as needed
                height: 300, // Adjust the height as needed
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
                  title: Text(
                    'Due Date: ${dueDate != null ? dueDate!.toString().split(' ')[0] : 'Not Set'}',
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
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
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty &&
                        dueDate != null) {
                      taskController.addTask(Task(
                        title: titleController.text,
                        description: descriptionController.text,
                        dueDate: dueDate!,
                      ));
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.amber,
                    shadowColor: Colors.black,
                  ),
                  child: const Text(
                    'Add Task',
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
