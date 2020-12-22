import 'package:context/controller/TodoController.dart';
import 'package:context/models/Todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoController>(builder: (context, todoController, child) {
      // mais outro consumidor (sem aquele tanto de parâmetro)
      bool isEdit =
          todoController.todoActive != null; //se não está nulo, está editando
      final controllerTextDescription = TextEditingController(
          text: isEdit ? todoController.todoActive.description : null);
      final formKey = GlobalKey<FormState>();
      return AlertDialog(
        title: Text(isEdit ? "Alterar tarefa" : "Adicionar tarefa"),
        content: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: "Tarefa"),
                    controller: controllerTextDescription,
                    validator: (text) {
                      return text.length > 1 ? null : "Obrigatório";
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          RaisedButton(
            child: Text('Salvar'),
            onPressed: () {
              if (formKey.currentState.validate()) {
                if (isEdit) {
                  todoController.updateTodo(
                      todoController.todoActive,
                      Todo(
                          description: controllerTextDescription.text,
                          status: todoController.todoActive.status));
                } else {
                  todoController.addTodo(Todo(
                    description: controllerTextDescription.text,
                  ));
                }
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    });
  }
}
