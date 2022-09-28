import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/task_controller.dart';
import 'package:todo_app/ui/homeScreen/homeScreenComponents.dart';
import 'package:todo_app/ui/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notify;
  //DateTime now = DateTime.now();
  //late DateTime _selectedDate = now;
  final _taskController = Get.put(TaskController());
  var hsm = HomeScreenComponents();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: prefer_const_constructors
    notify = Notify();
    notify.initializeNotification();
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addAppBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          hsm.addTaskBar(),
          hsm.addDateBar(),
          const SizedBox(
            height: 15,
          ),
          showTasks(),
        ],
      ),
    );
  }

  void deleteTask() {}

  void completeTask() {}

  addAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notify.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Light Theme"
                  : "Activated Dark Theme");
          notify.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.lightbulb_circle : Icons.light_mode,
          size: 20,
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

  showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskLists.length,
            itemBuilder: (context, index) {
              return Slidable(
                closeOnScroll: true,
                startActionPane: ActionPane(
                    openThreshold: 0.05,
                    closeThreshold: 0.05,
                    motion: const StretchMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(16),
                        autoClose: true,
                        spacing: 6,
                        onPressed: ((context) {
                          setState(() {
                            _taskController
                                .deleteDb(_taskController.taskLists[index]);
                            _taskController.getTasks();
                          });
                        }),
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ]),
                endActionPane: _taskController.taskLists[index].isCompleted == 0
                    ? ActionPane(
                        openThreshold: 0.05,
                        closeThreshold: 0.05,
                        motion: const DrawerMotion(),
                        extentRatio: 0.25,
                        children: [
                            SlidableAction(
                              borderRadius: BorderRadius.circular(16),
                              spacing: 6,
                              autoClose: true,
                              flex: 2,
                              onPressed: ((context) {
                                _taskController.updateDb(
                                    _taskController.taskLists[index].id!);
                                _taskController.getTasks();
                              }),
                              backgroundColor: const Color(0xFF7BC043),
                              foregroundColor: Colors.white,
                              icon: Icons.check_circle_rounded,
                              label: 'Completed',
                            ),
                          ])
                    : ActionPane(
                        openThreshold: 0.05,
                        closeThreshold: 0.05,
                        motion: const DrawerMotion(),
                        extentRatio: 0.25,
                        children: [
                            SlidableAction(
                              borderRadius: BorderRadius.circular(16),
                              spacing: 6,
                              autoClose: true,
                              flex: 2,
                              onPressed: ((context) {}),
                              backgroundColor: const Color(0xFF7BC043),
                              foregroundColor: Colors.white,
                              icon: Icons.add_reaction_outlined,
                              label: 'Cool',
                            ),
                          ]),
                child: AnimationConfiguration.staggeredList(
                    position: index,
                    child: FadeInAnimation(
                        child: Row(
                      children: [
                        TaskTile(_taskController.taskLists[index]),
                      ],
                    ))),
              );
            });
      }),
    );
  }
}
