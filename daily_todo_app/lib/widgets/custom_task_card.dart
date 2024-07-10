import 'package:flutter/material.dart';
import '../models/task.dart';

class CustomTaskCard extends StatelessWidget {
  final Task task; // yahan 'Tab' ko 'Task' se replace karein
  final VoidCallback onTap;
  final ValueChanged<bool?> onCheckboxChanged;

  CustomTaskCard({
    required this.task,
    required this.onTap,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: task.title,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title, style: Theme.of(context).textTheme.displayLarge), // text theme update
                      SizedBox(height: 5),
                      Text(task.description, style: Theme.of(context).textTheme.bodyLarge), // text theme update
                    ],
                  ),
                ),
                Checkbox(
                  value: task.isCompleted,
                  onChanged: onCheckboxChanged,
                  activeColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
