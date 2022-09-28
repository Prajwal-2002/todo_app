import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/task_controller.dart';
import 'package:todo_app/ui/homeScreen/homeScreenComponents.dart';
import 'package:todo_app/ui/input_field.dart';
import 'package:todo_app/ui/theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  var hsm = HomeScreenComponents();
  final TaskController _taskController = Get.put(TaskController());
  String _startTime = DateFormat.jm().format(DateTime.now()).toString();
  String _endTime = DateFormat.jm().format(DateTime.now()).toString();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  int _selectedColor = 0;

  String _selectedRepeat = 'None';
  List<String> remindRepeat = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Task",
              style: headingStyle(),
            ),
            const SizedBox(
              height: 15,
            ),
            MyInputField(
                title: 'Title*',
                hint: 'Enter title here.',
                ctr: _titleController,
                tia: TextInputAction.next),
            MyInputField(
                title: 'Note*',
                hint: 'Enter note here.',
                ctr: _noteController,
                tia: TextInputAction.next),
            MyInputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
                tia: TextInputAction.next),
            Row(
              children: [
                Expanded(
                    child: MyInputField(
                        title: 'Start Time',
                        hint: _startTime,
                        tia: TextInputAction.next,
                        widget: IconButton(
                            onPressed: () {
                              _getTimeFromUser(isStartTime: true);
                            },
                            icon: const Icon(
                              Icons.access_time_filled,
                              color: Colors.grey,
                            )))),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: MyInputField(
                        title: 'End Time',
                        hint: _endTime,
                        tia: TextInputAction.next,
                        widget: IconButton(
                            onPressed: () {
                              _getTimeFromUser(isStartTime: false);
                            },
                            icon: const Icon(
                              Icons.access_time_filled,
                              color: Colors.grey,
                            ))))
              ],
            ),
            MyInputField(
              title: "Remind",
              hint: '$_selectedRemind minutes early',
              tia: TextInputAction.next,
              widget: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down),
                elevation: 4,
                underline: Container(
                  height: 0,
                ),
                items: remindList.map<DropdownMenuItem<String>>((int valve) {
                  return DropdownMenuItem<String>(
                    value: valve.toString(),
                    child: Text(valve.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRemind = int.parse(value.toString());
                  });
                },
              ),
            ),
            MyInputField(
              title: "Repeat",
              hint: _selectedRepeat,
              tia: TextInputAction.next,
              widget: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down),
                elevation: 4,
                underline: Container(
                  height: 0,
                ),
                items:
                    remindRepeat.map<DropdownMenuItem<String>>((String valve) {
                  return DropdownMenuItem<String>(
                    value: valve,
                    child: Text(valve),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRepeat = value.toString();
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color",
                        style: titleStyle(),
                      ),
                      Wrap(
                          spacing: 8,
                          children: List<Widget>.generate(3, (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedColor = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.5),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: index == 0
                                      ? primaryClr
                                      : (index == 1 ? pinkClr : yellowClr),
                                  child: _selectedColor == index
                                      ? const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        )
                                      : Container(),
                                ),
                              ),
                            );
                          }))
                    ],
                  ),
                  SizedBox(
                    //margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 45,
                    width: 120,
                    child: TextButton(
                      onPressed: () {
                        _validate();
                        //Get.back();
                        //Get.snackbar('Notification', 'Welcome to Add Task Page');
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryClr),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
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
                      child: const Text('Create Task'),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  _validate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    }

    if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "Fields marked * are mandatory",
        overlayBlur: 0.72,
        barBlur: 100,
        icon: const Icon(Icons.warning_amber),
        snackPosition: SnackPosition.BOTTOM,
        //backgroundColor: Colors.red,
      );
    }
  }

  _addTaskToDb() async {
    await _taskController.addTask(
        taskModel: TaskModel(
            color: _selectedColor,
            remind: _selectedRemind,
            isCompleted: 0,
            title: _titleController.text,
            note: _noteController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            repeat: _selectedRepeat));
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickerTime = await showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));

    String _formattedTime = _pickerTime!.format(context);

    if (isStartTime) {
      setState(() {
        _startTime = _formattedTime;
      });
    }

    if (!isStartTime) {
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));

    setState(() {
      _selectedDate = _pickerDate ?? _selectedDate;
    });
  }

  _appBar(BuildContext cxt) {
    return AppBar(
      elevation: 0,
      backgroundColor: cxt.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
          Get.snackbar('Notification', 'Welcome to Home Page');
        },
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        Icon(
          Icons.person,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
