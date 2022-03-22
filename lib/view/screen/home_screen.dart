import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/controller/boolean_check_helper.dart';
import 'package:todo_list_app/controller/database/database_provider.dart';
import 'package:todo_list_app/controller/day_time_helper.dart';
import 'package:todo_list_app/controller/provider/refresh_items_provider.dart';
import 'package:todo_list_app/model/task_model.dart';
import 'package:todo_list_app/view/screen/task_screen.dart';

import '../widget/task_item_text_view.dart';
import '../widget/task_list_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.appTile}) : super(key: key);

  final String appTile;

  List<bool> checkBoolListGlobal = [];

  bool isFirstBootUp = true;

  late List<TaskModel> tasks;

  ///                     -----helper methods-----                              ////
  ///////////////////////////////////////////////////////////////////////////////Get all Tasks from database
  Future<List<TaskModel>> getAllElements() async {
    tasks = await DatabaseProvider.instance.readAllElements();

    return tasks;
  }

  ///////////////////////////////////////////////////////////////////////////////Navigate to task screen
  void navigateToItemScreen(BuildContext context, {required bool isNewTask, int? id}){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => TaskScreen(isNewTask: isNewTask, taskId: id,)))
        .then((value) => Provider.of<RefreshItemsProvider>(context, listen: false).refreshListItems());

  }


  ///                       ------Widgets------                                 ////

  @override
  Widget build(BuildContext context) {
    return Scaffold( //todo: can I change status color

      body: Container(
        color: Colors.black87,
        child: Column(

          children: [

            ///                                                                 /Custom AppBar
            Container(
              color: Colors.white12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 65, left: 25),
                    child: TaskItemTextView(
                        appTile,
                        fontSize: 40,
                        fontWeight: FontWeight.w200,
                        maxLines: 1
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 35),
                    child: Row(
                      children: [
                        TaskItemTextView(
                            DayTimeHelper.getDay(),
                            fontSize: 40,
                            fontWeight: FontWeight.w300,
                            maxLines: 1,
                        ),
                        TaskItemTextView(
                            "${DayTimeHelper.getMonth(DateTime.now().month)} \n${DayTimeHelper.getYear()}",
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            maxLines: 2
                        ),
                        const Spacer(), //Spacer to fill a space
                        TaskItemTextView(
                            DayTimeHelper.getDayOfWeek(DateTime.now().weekday),
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


            ///                                                                 /ListView of todos
            Expanded( //takes the space from the other column to fill the screen
              child: Consumer<RefreshItemsProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder(
                      future: getAllElements(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return tasks.isNotEmpty ?

                          ListView.builder(
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {


                                return InkWell(
                                  onTap: () {
                                    navigateToItemScreen(
                                        context, isNewTask: false, id: tasks[index].id);
                                  },
                                  child: TaskListItemBuilder(
                                      index: index,
                                      taskName: tasks[index].taskTitle!,
                                      taskDetail: tasks[index].taskDetail!,
                                      day: tasks[index].taskDay!,
                                      month: tasks[index].taskMonth!,
                                      year: tasks[index].taskYear!,
                                      taskModel: tasks[index],
                                      isChecked: BooleanCheckHelper.convertIntToBool(
                                          tasks[index].taskCheckStatus!
                                      ),
                                  ),
                                );

                              }
                          )


                              : Center(
                                  child: TaskItemTextView(
                                  "You can create a new task!",
                                  fontSize: 13,
                                  maxLines: 1,
                                ));

                        } else {
                          return const Center(child: CircularProgressIndicator(),);
                        }
                      }
                  );
                },
              ),),
          ],
        ),
      ),


      ///                                                                       /Floating Action Bar
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToItemScreen(
                context, isNewTask: true);
          },

          child: const Icon(Icons.add)
      ),

    );

  }

}
