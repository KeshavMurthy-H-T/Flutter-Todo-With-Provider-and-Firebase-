import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/api/FireBaseApi.dart';
import 'package:todo/model/TodoModel.dart';
import 'package:intl/intl.dart';

class TaskController extends ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> _todaysList = [];
  List<Todo> _data = [];

  bool isWorking = false;
  bool isLoader = true;

  set _isLoading(bool value) {
    isLoader = value;
    notifyListeners();
  }
  get loadScreen => isLoader;

  get todoList => _todos;

  get todoListTodaysDate => _data;

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  List<Todo> get todaysTodo => _data.where((t) => t.isDone == false).toList();

  List<Todo> get todaysCompleted =>
      _data.where((t) => t.isDone == true).toList();

  Future<void> readAllTodo(userId) async {
    
    _todos = (await FirebaseApi.instance!.readData(userId))!;
    _todos.sort((a, b) => a.taskDate.compareTo(b.taskDate));
_isLoading =false;
    notifyListeners();
  }

  Future<void> readTodoByDate(userId, todaysDate) async {
    var dateFormat = DateFormat('yyyy-MM-dd');
      
    _todaysList = await FirebaseApi.instance!.readDataByDate(userId)!;
    _data = _todaysList
        .where((element) => dateFormat.format(element.taskDate) == todaysDate)
        .toList();
        _isLoading =false;
    notifyListeners();
  }

  void deleteTodo(Todo todo) => FirebaseApi.instance!.deleteTodo(todo);

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.instance!.updateTodo(todo);

    return todo.isDone;
  }

  Future<String?> updateTodo(
      Todo todo, String title, String description, DateTime updateddate) async {
    todo.title = title;
    todo.description = description;
    todo.taskDate = updateddate;
    return await FirebaseApi.instance!.updateTodo(todo);
  }

  Future<String?> updateTodoCompleted(Todo todo) async {
    todo.isDone = true;
    return await FirebaseApi.instance!.updateTodo(todo);
  }

  Future<String?> addTaskToFirebase(
      User user, String title, String description, DateTime taskdate) async {
    var userId = user.uid;
    var isComleted = false;

    final todoTask = Todo(
        title: title,
        description: description,
        taskDate: taskdate,
        isDone: isComleted,
        userId: userId);
    return await FirebaseApi.instance!.createTodo(todoTask);
  }
}
