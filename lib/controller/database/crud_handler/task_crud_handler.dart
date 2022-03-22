import '../../../model/task_model.dart';
import '../../boolean_check_helper.dart';
import '../database_provider.dart';

class CRUDHandler {

  CRUDHandler({
    required this. taskId,
    required this. title,
    required this. taskDetails,
    required this. pickedDay,
    required this. pickedMonth,
    required this. pickedYear,
  });

  int? taskId;
  String title;
  String taskDetails;
  int pickedDay;
  int pickedMonth;
  int pickedYear;


  ///                                                                           /createTask function
  Future<void> createTask() async {


    DatabaseProvider.instance.createNote(TaskModel(
        taskTitle: title, //_titleController.text
        taskDetail: taskDetails, //_detailController.text
        taskCheckStatus: BooleanCheckHelper.convertBoolToInt(false),
        taskDay: pickedDay,
        taskMonth: pickedMonth,
        taskYear: pickedYear));
  }


  ///                                                                           /saveTask function
  Future<void> saveTask({required int checkStatus}) async {

    DatabaseProvider.instance.updateNote(TaskModel(
        id: taskId, //widget.taskId
        taskTitle: title,
        taskDetail: taskDetails,
        taskCheckStatus: checkStatus,
        taskDay: pickedDay,
        taskMonth: pickedMonth,
        taskYear: pickedYear));

  }


  ///                                                                           /deleteTask function
  Future<void> deleteTask() async {
    DatabaseProvider.instance.deleteNote(taskId);
  }
}
