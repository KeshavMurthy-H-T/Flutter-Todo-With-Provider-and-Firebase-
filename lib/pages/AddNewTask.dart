import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/TaskController.dart';
import 'package:todo/service/auth.dart';
import 'package:todo/utils/ColorConstants.dart';
import 'package:todo/utils/Constants.dart';
import 'package:todo/utils/utils.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDesc = TextEditingController();
  TextEditingController taskDate = TextEditingController();
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              elevation: 0.0,
              leading: IconButton(
                iconSize: 30,
                icon: Icon(Icons.arrow_back, color: accentColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: primaryColor,
              centerTitle: true,
              title: const Text("Add new task")),
          body: Container(
            color: primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Icon(
                      Icons.task_outlined,
                      size: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: taskTitle,
                      style: Constants.formtextStyle(context),
                      decoration: InputDecoration(
                        hintText: "Task Name",
                        hintStyle: Constants.textlableStyle(context),
                        errorStyle: const TextStyle(
                          fontSize: 16.0,
                        ),
                        //contentPadding: const EdgeInsets.all(8.0),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter the task title.';
                        }
                        return null;
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: taskDesc,
                      minLines: 1,
                      maxLines: 5,
                      style: Constants.formtextStyle(context),
                      decoration: InputDecoration(
                        hintText: "Task Description",
                        hintStyle: Constants.textlableStyle(context),
                        // contentPadding: const EdgeInsets.all(8.0),
                        errorStyle: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter the task description.';
                        }
                        return null;
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: taskDate,
                      showCursor: true,
                      readOnly: true,
                      style: Constants.formtextStyle(context),
                      decoration: InputDecoration(
                        hintText: "Task DateTime",
                        hintStyle: Constants.textlableStyle(context),
                        //contentPadding: const EdgeInsets.all(8.0),
                        errorStyle: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      cursorColor: Colors.white,
                      keyboardType: null,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please select the task date.';
                        }
                        return null;
                      },
                      onTap: () async {
                        final DateFormat formatter = DateFormat('dd-MMM-yyyy');

                        DateTime? date = DateTime.now();
                        FocusScope.of(context).requestFocus(FocusNode());

                        date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100));

                        selectedDate = date;

                        taskDate.text = formatter.format(date!);
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            var userData = context.read<AuthMethods>().user;

                            if (_formKey.currentState!.validate()) {
                              buildShowDialog(context);
                              final response = await context
                                  .read<TaskController>()
                                  .addTaskToFirebase(userData, taskTitle.text,
                                      taskDesc.text, selectedDate!);
                              if (response != null) {
                                moveBack();
                                showSnackBar(
                                    context, "Added the task to list ");
                              } else {
                                Navigator.of(context).pop();
                                showSnackBar(context,
                                    "Something went wrong.. Please try again");
                              }
                            }
                          },
                          child: Text(
                            "Add Task",
                            style: Constants.buttonTextlableStyle(context),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              color: accentColor,
              backgroundColor: Colors.red,
            ),
          );
        });
  }

  moveBack() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  cleartextFields() {
    taskTitle.clear();
    taskDesc.clear();
    taskDate.clear();
  }

  @override
  void dispose() {
    super.dispose();
    taskTitle.dispose();
    taskDesc.dispose();
    taskDate.dispose();
  }
}
