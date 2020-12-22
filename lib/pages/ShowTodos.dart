import 'package:context/controller/TodoController.dart';
import 'package:context/models/TodoStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowTodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoController>(
      //consumidor para a lista
      builder: (context, todoController, child) {
        //o todoController é a instância da classe que o provider disponibilizou
        return ListView(
          children: todoController.todos
              .map(
                (todo) => Container(
                  color: todo.status == TodoStatus.DONE ? Colors.green : null,
                  child: ListTile(
                    leading: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          todoController.removeTodo(todo);
                        }),
                    title: Text(todo.description),
                    trailing: IconButton(
                      icon: Icon(
                        todo.status == TodoStatus.DONE
                            ? Icons.undo
                            : Icons.check,
                      ),
                      onPressed: () {
                        todoController.changeStatus(
                          todo,
                          todo.status == TodoStatus.DONE
                              ? TodoStatus.TODO
                              : TodoStatus.DONE,
                        );
                      },
                    ),
                    enabled: true,
                    onLongPress: () {
                      todoController.setTodoActive(todo);
                    },
                    onTap: () {
                      todoController.setTodoActive(null);
                    },
                  ),
                ),
              )
              .toList(), //encontrei uma forma sem usar o for... mas não sei se funciona corretamente, até agora tá ok!
        );
      },
    );
  }
}
