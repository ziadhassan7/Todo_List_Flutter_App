import 'package:todo_list_app/controller/database/constants.dart';

class TaskModel {
  final int? id;
  final String? taskTitle;
  final String? taskDetail;
  final int? taskCheckStatus;
  final int? taskDay;
  final int? taskMonth;
  final int? taskYear;

  TaskModel({
    this.id,
    this.taskTitle,
    this.taskDetail,
    this.taskCheckStatus,
    this.taskDay,
    this.taskMonth,
    this.taskYear,
  });

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnTitle: taskTitle,
      columnDetail: taskDetail,
      columnCheckStatus: taskCheckStatus,
      columnDay: taskDay,
      columnMonth: taskMonth,
      columnYear: taskYear,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map[columnId],
      taskTitle: map[columnTitle],
      taskDetail: map[columnDetail],
      taskCheckStatus: map[columnCheckStatus],
      taskDay: map[columnDay],
      taskMonth: map[columnMonth],
      taskYear: map[columnYear],
    );
  }
}