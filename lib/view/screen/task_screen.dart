import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/controller/color_picker_handler.dart';
import 'package:todo_list_app/controller/database/database_provider.dart';
import 'package:todo_list_app/controller/provider/pick_date_provider.dart';
import 'package:todo_list_app/model/task_model.dart';

import '../../controller/database/crud_handler/task_crud_handler.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({Key? key, this.taskId, required this.isNewTask})
      : super(key: key);

  //Global Variables
  final bool isNewTask;

  int? taskId;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  late TaskModel task;

  int checkState = 0;
  int pickedDay = 0;

  int pickedMonth = 0;

  int pickedYear = 0;

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _detailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() { //todo ^_^ 2
    super.initState();

    Provider.of<PickDateProvider>(context, listen: false).pickedDay = 0;
  }

  @override
  Widget build(BuildContext context) {
    ///                                                                         /Handles system back press
    return WillPopScope(
      onWillPop: () {
        navigateBackAndSave(context);

        return Future.value(false);
      },

      ///                                                                       /Scaffold with color
      child: Scaffold(
        backgroundColor: Colors.white24, //todo: different transparent color than home screen caused a lagging behaviour

        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ///                                                               /Custom AppBar//
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    /////////////////////////////////////////////////////////////Back arrow icon
                    IconButton(
                      onPressed: () {
                        navigateBackAndSave(context);
                      },
                      iconSize: 30,
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white38,
                      ),
                    ),

                    const Spacer(),

                    /////////////////////////////////////////////////////////////Delete icon
                    IconButton(
                      onPressed: () {
                        handleDeleteButton(context);
                      },
                      iconSize: 30,
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),

              ///                                                               /Main Body//
              ///
              FutureBuilder(
                  future: _getCurrentTask(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      _titleController.text = task.taskTitle!;
                      _detailController.text = task.taskDetail!;

                      checkState = task.taskCheckStatus!;

                      pickedDay = task.taskDay!;
                      pickedMonth = task.taskMonth!;
                      pickedYear = task.taskYear!;
                    }

                    return mainBody(context);
                  }),

              //const Spacer(),

              ///                                                               /Color Picker//
              /*Expanded( //you have to put it for any list view
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ColorPickerHandler.colorList.length,

                  itemBuilder: (context, index) {
                    return circularColorPicker(index, 0);
                  }
                ),
              )*/

              /*const Spacer(),
              bottomColorPicker(),*/
            ],
          ),
        ),
      ),
    );
  }


  ///                       ------Widgets------                                 ////

  /// /Main Body Column
  Widget mainBody(BuildContext context,
      {String? taskTitle, String? taskDetail}) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///                                                                 /TextFormField - Task Name
            Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                child: textFormField(
                  hintText: "New Task",
                  controller: _titleController,
                )),

            ///                                                                 /TextFormField - Task Details
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35, top: 12),
              child: textFormField(
                hintText: "Task Details...",
                fontSize: 20,
                controller: _detailController,
              ),
            ),

            ///                                                                 /Pick Date Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
              child: pickDateButton(context, text: "Pick time"),
            ),
          ],
        ),
      ),
    );
  }

  /// /Custom TextFormField
  TextFormField textFormField(
      {String? text,
        String? hintText,
        double fontSize = 40,
        required TextEditingController controller}) {

    return TextFormField(
      initialValue: text,
      controller: controller,
      style: TextStyle(
          color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold),
      //text color
      maxLines: null,
      //make it expandable a user type
      decoration: InputDecoration(
        border: InputBorder.none, //make it borderless
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white38),
        //fillColor: Colors.white12, //Colors.white12 //Colors.black87
        //filled: true,
      ),
    );
  }

  ///                                                                           /Calendar Picker
  ///////////////////////////////////////////////////////////////////////////////button
  Widget pickDateButton(BuildContext context, {String? text}) {
    return Consumer<PickDateProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            InkWell(
              onTap: () {
                _selectDate(context, provider);
              },
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.today,
                      color: Colors.white,
                    ),
                  ),
                  datePickerButtonFiller(provider),
                ],
              ),
            ),
            if (pickedDay != 0)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: InkWell(
                  onTap: () {

                    Provider.of<PickDateProvider>(context, listen: false)
                        .changeDateButton(
                        0, 0, 0); //resets Provider variables //t

                    resetDates(); //resets global variables
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  ///////////////////////////////////////////////////////////////////////////////Text inside of button
  Widget datePickerButtonFiller(PickDateProvider provider) {

    if ( pickedDay != 0) {
      return Row(
        children: [
          Text("$pickedDay/$pickedMonth/$pickedYear",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ],
      );


    }

    return const Text("Pick Day",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold));
  }


  ///////////////////////////////////////////////////////////////////////////////The Date Picker Widget
  Future<void> _selectDate(
      BuildContext context, PickDateProvider provider) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black87, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.orange, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      provider.changeDateButton(
        pickedDate.day,
        pickedDate.month,
        pickedDate.year,
      );

      //save values in global variable for the save() function
      pickedDay = pickedDate.day;
      pickedMonth = pickedDate.month;
      pickedYear = pickedDate.year;

    } else {
      print ("provider didn't even work");
    }
  }


  /// /Color Picker Row
  Widget circularColorPicker(int index, int userChoice) {
    double smallCircleSize = 15;
    double circleSizeWithBorder = smallCircleSize + 5;

    bool isChecked = false;

    if (userChoice == index) {
      isChecked = true;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white38,
        radius: circleSizeWithBorder,
        child: CircleAvatar(
          backgroundColor: ColorPickerHandler.getColorByIndex(index),
          radius: isChecked ? smallCircleSize : circleSizeWithBorder,
          child: isChecked
              ? const Icon(
            Icons.check,
            color: Colors.black54,
          )
              : null,
        ),
      ),
    );
  }





  ///                     -----helper methods-----                              ////
  ///////////////////////////////////////////////////////////////////////////////getCurrentTask function
  Future<TaskModel> _getCurrentTask() async {
    task = await DatabaseProvider.instance.readOneElement(widget.taskId);

    return task;
  }

  ///////////////////////////////////////////////////////////////////////////////back and save function
  void navigateBackAndSave(BuildContext context) {
    if (_titleController.text.isNotEmpty || _detailController.text.isNotEmpty) {

      CRUDHandler crudHandler = CRUDHandler(
        taskId: widget.taskId,
        title: _titleController.text,
        taskDetails: _detailController.text,
        pickedDay: pickedDay,
        pickedMonth: pickedMonth,
        pickedYear: pickedYear,
      );

      if (widget.isNewTask) {
        crudHandler.createTask();

      } else {
        crudHandler.saveTask(checkStatus: checkState);
      }
    }

    Navigator.pop(context);
  }

  ///////////////////////////////////////////////////////////////////////////////handle delete button
  void handleDeleteButton(BuildContext context) {
    //if it isn't a new task
    if (!widget.isNewTask) {

      CRUDHandler crudHandler = CRUDHandler(
        taskId: widget.taskId!,
        title: _titleController.text,
        taskDetails: _detailController.text,
        pickedDay: pickedDay,
        pickedMonth: pickedMonth,
        pickedYear: pickedYear,
      );

      crudHandler.deleteTask();
      Navigator.pop(context);

      // it is a new task but user wants to discard
    } else {
      if (_titleController.text.isNotEmpty ||
          _detailController.text.isNotEmpty) {
        Navigator.pop(context);
      }
    }
  }

  ///////////////////////////////////////////////////////////////////////////////resets global dates
  void resetDates() {
    pickedDay = 0;
    pickedMonth = 0;
    pickedYear = 0;
  }
}
