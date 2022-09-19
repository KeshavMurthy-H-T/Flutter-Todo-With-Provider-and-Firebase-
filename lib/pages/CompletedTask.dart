import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/TaskController.dart';
import 'package:todo/model/TodoModel.dart';
import 'package:todo/service/auth.dart';
import 'package:todo/utils/ColorConstants.dart';
import 'package:todo/utils/Constants.dart';
import 'package:todo/utils/utils.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({Key? key}) : super(key: key);

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthMethods>().user;
    context.watch<TaskController>().readAllTodo(user.uid);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              iconSize: 30,
              icon: Icon(Icons.arrow_back, color: accentColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: primaryColor,
            centerTitle: true,
            title: const Text("Completed task")),
        body: Container(
          color: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Consumer<TaskController>(
                    builder: (context, taskData, child) {
                      if (taskData.loadScreen) {
                        return buildLoader();
                      } else if (taskData.todosCompleted.isEmpty) {
                        return Center(
                            child: Text(
                          'There are no data for Completed task...\n Complete the Task to view.',
                          style: Constants.bodyErrorText(context),
                        ));
                      } else if (taskData.todosCompleted.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: taskData.todosCompleted.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    popUpViewDialog(context,
                                        taskData.todosCompleted[index]);
                                  },
                                  child: TodoCardView(
                                    todo: taskData.todosCompleted[index],
                                  ));
                            });
                      } else {
                        return Center(
                            child: Text(
                          'Something went wrong... Please try again later',
                          style: Constants.bodyErrorText(context),
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void popUpViewDialog(BuildContext context, todo) {
    var dateFormat = DateFormat('dd-MMM-yyyy');
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Todo Task",
                          style: Constants.textHeaderBoldwithColor(
                              context, primaryColor),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        todo.title.toString().capitalize(),
                        style: Constants.textHeader(context),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        todo.description.toString().capitalize(),
                        style: Constants.bodyBoldText(context),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateFormat.format(todo.taskDate).toString(),
                            style: Constants.bodytext(context),
                          ),
                          Text(
                            (todo.isDone == true) ? "Completed" : "Pending",
                            style: Constants.textHeaderwithColor(
                                context, Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "OK",
                                style: Constants.buttonTextlableStyle(context),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  showAlertDialogForMarkDone(
      BuildContext context, String title, String message, todo) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    context.read<TaskController>().updateTodoCompleted(todo);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes")),
            ],
          );
        });
  }
}

class TodoCardView extends StatelessWidget {
  const TodoCardView({Key? key, required this.todo}) : super(key: key);

  final Todo todo;
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var dateFormat = DateFormat('dd-MMM-yyyy');
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: deviceSize.width * 65 / 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dateFormat.format(todo.taskDate).toString(),
                        style: Constants.textHeaderwithColor(
                            context, primaryColor),
                      ),
                      Text(
                        (todo.isDone == true) ? "Completed" : "Pending",
                        style: Constants.textHeaderwithColor(
                            context, Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    todo.title.toString().capitalize(),
                    style: Constants.textHeader(context),
                  ),
                  Text(
                    todo.description.toString().capitalize(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Constants.bodyBoldText(context),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showAlertDialogForDelete(context, "Conform Dialog",
                        "Are you sure you want to delete this task");
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showAlertDialogForDelete(BuildContext context, String title, String message) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    context.read<TaskController>().deleteTodo(todo);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes")),
            ],
          );
        });
  }
}
