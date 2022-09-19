import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/TaskController.dart';
import 'package:todo/model/TodoModel.dart';
import 'package:todo/pages/AddNewTask.dart';
import 'package:todo/pages/NavDrawer.dart';
import 'package:todo/service/auth.dart';
import 'package:todo/utils/ColorConstants.dart';
import 'package:todo/utils/Constants.dart';
import 'package:intl/intl.dart';
import 'package:todo/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('yyyy-MM-dd');
    var todaysDate = dateFormat.format(DateTime.now());
    var deviceSize = MediaQuery.of(context).size;
    final user = context.read<AuthMethods>().user;
    Provider.of<TaskController>(context, listen: true)
        .readTodoByDate(user.uid, todaysDate);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: NavDrawer(user: user),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                Stack(
                  children: <Widget>[
                    SizedBox(
                        height: deviceSize.height / 3.5,
                        width: deviceSize.width,
                        child: Image.asset(
                          'assets/background3.jpg',
                          fit: BoxFit.fill,
                        )),
                    Positioned(
                      top: 50,
                      left: 20,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello",
                                  style: Constants.sideMenuHeaderStyle(context),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Your Todays Todo Task",
                                  style: Constants.sideMenuHeaderStyle(context),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  DateFormat('dd-MMM-yyy')
                                      .format(DateTime.now())
                                      .toString(),
                                  style: Constants.formtextStyle(context),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 30,top: 40),
                              child: Column(
                                children: [
                                  Text(
                                    context
                                        .read<TaskController>()
                                        .todaysTodo
                                        .length
                                        .toString(),
                                    style:
                                        Constants.numberTextStyle(context),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "pending",
                                    style:
                                        Constants.sideMenuHeaderStyle(context),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                  color: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Text(
                            "To Do Tasks",
                            style: Constants.appBarTextStyle(context),
                          ),
                        ),
                        SizedBox(
                          height: deviceSize.height / 1.9,
                          child: Consumer<TaskController>(
                              builder: (context, todoData, _) {

                                if(todoData.loadScreen){
                                    return buildLoader();
                                }else 
                            if (todoData.todaysTodo.isEmpty) {
                              return Center(
                                  child: Text(
                                "There are no task added.. \n For Todays Dates",
                                style: Constants.textHeader(context),
                              ));
                            } else if (todoData.todaysTodo.isNotEmpty) {
                              return ListView.builder(
                                itemCount: todoData.todaysTodo.length,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    child: HomePageTaskList(
                                        todoData: todoData.todaysTodo[index]),
                                    onTap: () {
                                      popUpViewDialog(
                                          context, todoData.todaysTodo[index]);
                                    },
                                  );
                                }),
                              );
                            } else {
                              return Center(
                                  child: Text(
                                'Something went wrong... Please try again later',
                                style: Constants.bodytext(context),
                              ));
                            }
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 20,
                              child: Text(
                                "COMPLETED",
                                style: Constants.appBarTextStyle(context),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Center(
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(100)
                                    //more than 50% of width makes circle
                                    ),
                                child: Center(
                                  child: Text(
                                    context
                                        .read<TaskController>()
                                        .todaysCompleted
                                        .length
                                        .toString(),
                                    style: Constants.bodyBoldText1(context),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            Positioned(
              left: 10.0,
              top: 10.0,
              child: InkWell(
                child: const Icon(
                  Icons.menu_rounded,
                  size: 30.0,
                  color: Colors.white,
                ),
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, right: 10.0),
          child: FloatingActionButton(
            elevation: 6.0,
            tooltip: "Add New Task",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddNewTask()));
            },
            child: const Icon(Icons.add),
            backgroundColor: accentColor,
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
                height: MediaQuery.of(context).size.height /2,
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
                        todo.description.toString(),
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
                                context, Colors.deepOrange),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showAlertDialogForMarkDone(
                                  context,
                                  "Confirm Dialog",
                                  "Are you sure the task is completed... You want to proceed.",
                                  todo);
                            },
                            child: Text(
                              "Mark Completed",
                              style: Constants.buttonTextlableStyle(context),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "OK",
                              style: Constants.buttonTextlableStyle(context),
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
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes")),
            ],
          );
        });
  }
}

class HomePageTaskList extends StatelessWidget {
  const HomePageTaskList({Key? key, required this.todoData}) : super(key: key);
  final Todo todoData;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0,top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.pending_actions,size: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: deviceSize.width * 72 / 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(todoData.title.toString().capitalize(),
                          style: Constants.textHeader(context)),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(todoData.description.toString().capitalize(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Constants.bodytext(context)),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15.0),
              //   child: Text("12pm", style: Constants.bodyBoldText(context)),
              // )
            ],
          ),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}
