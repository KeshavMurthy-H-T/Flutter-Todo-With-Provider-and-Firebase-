import 'package:todo/utils/utils.dart';

class Todo {
  String? id;
  String? title;
  String? description;
  DateTime taskDate;
  bool isDone;
  String? userId;

  Todo(
      {this.id,
      this.title,
      this.description,
      required this.taskDate,
      this.isDone = false,
      this.userId});

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        taskDate: (json['taskDate']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        isDone: json['isDone'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'taskDate': Utils.fromDateTimeToJson(taskDate),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
        'userId': userId
      };
}
