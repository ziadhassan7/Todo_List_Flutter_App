import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/view/widget/task_item_text_view.dart';

import '../../controller/boolean_check_helper.dart';
import '../../controller/database/database_provider.dart';
import '../../controller/due_date_helper.dart';
import '../../controller/provider/refresh_items_provider.dart';
import '../../model/task_model.dart';

class TaskListItemBuilder extends StatelessWidget {
  TaskListItemBuilder({
    required this. index,
    required this. taskName,
    required this. taskDetail,
    required this. day,
    required this. month,
    required this. year,
    required this. taskModel,
    required this. isChecked,
    Key? key,
  }) : super(key: key);

  int index;
  String taskName;
  String taskDetail;
  int day;
  int month;
  int year;
  TaskModel taskModel;
  bool isChecked;


  ///                     -----helper methods-----                              ////
  ///////////////////////////////////////////////////////////////////////////////save task
  Future<void> _saveTask(TaskModel model, bool newCheckStatus) async { //you can't skip a variable

    DatabaseProvider.instance.updateNote(TaskModel(
        id: model.id,
        taskTitle: model.taskTitle,
        taskDetail: model.taskDetail,
        taskCheckStatus: BooleanCheckHelper.convertBoolToInt(newCheckStatus),
        taskDay: model.taskDay,
        taskMonth: model.taskMonth,
        taskYear: model.taskYear


    )).whenComplete(() => print("saved! ^_^"));

    print("saved! ^_^ ${BooleanCheckHelper.convertBoolToInt(newCheckStatus)}");
  }


  ///                         -----Widget----                                   ////
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.black54,
        shape: RoundedRectangleBorder( //for rounded corners
            borderRadius: BorderRadius.circular(12)
        ),
        child: SizedBox(
            height: 100,

            child: Row(
              children: [

                ///Check box
                Transform.scale( //make any view bigger (force scaling!)
                  scale: 1.2,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.orange,
                    ),
                    child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.deepOrange,
                        shape: const CircleBorder(),
                        //Make it circular
                        visualDensity: const VisualDensity(horizontal: 3.5),
                        //Acts as margin
                        onChanged: (bool? value) {


                          _saveTask(taskModel, value!);


                          Provider.of<RefreshItemsProvider>(context, listen: false).refreshListItems();
                        },

                        value: BooleanCheckHelper.convertIntToBool(taskModel.taskCheckStatus!) //isFirstBootUp ? BooleanCheckHelper.convertIntToBool(tasks[index].taskCheckStatus!) : provider.checkBoolList[index], //it will be refreshed for all items so each value must be unique
                    ),
                  ),
                ),

                ///Text
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, //todo ^_^ 2
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.78, //todo ^_^ 1
                        child: TaskItemTextView(
                          taskName,
                          isCrossed: isChecked,
                          fontSize: 18,
                          maxLines: 1,
                        ),
                      ),

                      const Spacer(),

                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.78, //todo ^_^ 1
                          child: Text(taskDetail,
                            style: const TextStyle(fontSize: 14, color: Colors.white38,),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.78, //todo ^_^ 1

                        child: Row(

                          children: [
                            const Spacer(),
                            Text(DueDateHelper.getDueDate(year, month, day), style: const TextStyle(fontSize: 14, color: Colors.white38,), maxLines: 1,),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )


        ),
      ),
    );;
  }
}
