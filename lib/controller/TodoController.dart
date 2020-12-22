import 'package:context/models/Todo.dart';
import 'package:context/models/TodoStatus.dart';
import 'package:flutter/material.dart';

class TodoController extends ChangeNotifier {
  List<Todo> todos = List<Todo>();
  Todo todoActive;

  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    todos.remove(todo);
    notifyListeners();
  }

  void changeStatus(Todo todo, TodoStatus status) {
    todos.replaceRange(todos.indexOf(todo), todos.indexOf(todo) + 1,
        [Todo(description: todo.description, status: status)]);
    notifyListeners();
  }

  void updateTodo(Todo oldTodo, Todo newTodo) {
    todos.replaceRange(
        todos.indexOf(oldTodo), todos.indexOf(oldTodo) + 1, [newTodo]);
    notifyListeners();
  }

  void setTodoActive(Todo todo) {
    todoActive = todo;
    notifyListeners();
  }
}
