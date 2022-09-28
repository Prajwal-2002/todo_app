import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/task_controller.dart';
import 'package:todo_app/ui/homeScreen/add_task_bar.dart';
import '../theme.dart';

class HomeScreenComponents {
  DateTime now = DateTime.now();
  late DateTime _selectedDate = now;
  var _taskController = Get.put(TaskController());

  addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        now,
        height: 100,
        width: 80,
        initialSelectedDate: now,
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          _selectedDate = date;
        },
        dateTextStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        dayTextStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        monthTextStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
    );
  }

  addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(now),
                style: subHeadingStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Today",
                style: headingStyle(),
              ),
            ],
          ),
          SizedBox(
            //margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            width: 120,
            child: TextButton(
              onPressed: () async {
                await Get.to(() => const AddTaskPage());
                _taskController.getTasks();
                //  .getTasks(); //used to refresh the newly added task to the database;
                //Get.snackbar('Notification', 'Welcome to Add Task Page');
              },
              child: const Text('+ Add Task'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0))),
                backgroundColor: MaterialStateProperty.all<Color>(primaryClr),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.blue.withOpacity(0.04);
                    }
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed)) {
                      return Colors.blue.withOpacity(0.12);
                    }
                    return null; // Defer to the widget's default.
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
