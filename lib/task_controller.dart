import 'dart:async';

import 'package:get/get.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/model/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  final RxList<TaskModel> taskLists = List<TaskModel>.empty().obs;

  //var taskLists = DbHelper.tasks();

  Future<int?> addTask({required TaskModel taskModel}) async {
    return await DbHelper.insertTask(taskModel);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DbHelper.tasks();
    taskLists
        .assignAll(tasks.map((data) => new TaskModel.fromJson(data)).toList());
    //Rx means reactive streams in GetX
  }

  void deleteDb(TaskModel task) {
    DbHelper.delete(task);
  }

  void updateDb(int id) async {
    await DbHelper.update(id);
  }
}
