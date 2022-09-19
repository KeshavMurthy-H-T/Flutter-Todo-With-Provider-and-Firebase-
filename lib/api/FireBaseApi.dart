import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/TodoModel.dart';
import 'package:todo/utils/utils.dart';

class FirebaseApi {
  static FirebaseApi? _instance;
  FirebaseApi._();

  static FirebaseApi? get instance {
    // ignore: prefer_conditional_assignment
    if (_instance == null) {
      _instance = FirebaseApi._();
    }
    return _instance;
  }

  Future<String?> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo-tasks').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    if (docTodo.id != null) {
      return docTodo.id;
    }

    return null;
  }

  static Stream<List<Todo>> readTodos() {
    return FirebaseFirestore.instance
        .collection('todo-tasks')
        .snapshots()
        .transform(Utils.transformer(Todo.fromJson));
  }

  Future<List<Todo>>? readData(userId) async {
    List<Todo> toDoList = [];
    await FirebaseFirestore.instance
        .collection('todo-tasks')
        .where('userId', isEqualTo: userId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        var todo = Todo(
          id: doc['id'],
          title: doc['title'],
          isDone: doc['isDone'],
          taskDate: doc['taskDate'].toDate(),
          description: doc['description'],
          userId: doc['userId'],
        );
        toDoList.add(todo);
      }
    });
    return toDoList;
  }

  Future<List<Todo>>? readDataByDate(userId) async {
    
    List<Todo> toDoList = [];
    await FirebaseFirestore.instance
        .collection('todo-tasks')
        .where('userId', isEqualTo: userId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        var todo = Todo(
          id: doc['id'],
          title: doc['title'],
          isDone: doc['isDone'],
          taskDate: doc['taskDate'].toDate(),
          description: doc['description'],
          userId: doc['userId'],
        );
        toDoList.add(todo);
      }
    });
    return toDoList;
  }

  Future updateTodo(Todo todo) async {
    try {
      final docTodo =
          FirebaseFirestore.instance.collection('todo-tasks').doc(todo.id);

      await docTodo.update(todo.toJson());
    } catch (e) {
      return null;
    }

    return "Updated";
  }

  Future deleteTodo(Todo todo) async {
    final docTodo =
        FirebaseFirestore.instance.collection('todo-tasks').doc(todo.id);

    await docTodo.delete();
  }
}
