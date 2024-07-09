import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../widgets/custom_input_field.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  final int index;

  EditTaskScreen({required this.task, required this.index});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TaskController taskController = Get.find();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime dueDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
    dueDate = widget.task.dueDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Edit Task', style: Theme.of(context).textTheme.displayLarge),
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
                        descriptionController.text.isNotEmpty) {
                      taskController.updateTask(
                          widget.index,
                          Task(
                            title: titleController.text,
                            description: descriptionController.text,
                            isCompleted: widget.task.isCompleted,
                            dueDate: dueDate,
                          ));
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.amber,
                      backgroundColor: Colors.amber,
                      shadowColor: Colors.black),
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
