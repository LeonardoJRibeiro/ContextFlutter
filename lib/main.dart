import 'package:context/controller/TodoController.dart';
import 'package:context/pages/AddTodo.dart';
import 'package:context/pages/ShowTodos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Todo List com provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider<TodoController>(
          //provê uma instância da classe TodoController para todos os elementos filhos
          create: (BuildContext context) =>
              TodoController(), // instancia a classe TodoController
          child: Home(), //chama o componente principal
        ),
      );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoController>(
      // o primeiro consumidor, por causa do FloatingActionButton (FAB)
      builder: (context, todoController, child) {
        //o todoController é a instância da classe que o provider disponibilizou
        return Scaffold(
          appBar: AppBar(
            title: Text("Lista de tarefas"),
          ),
          body: ShowTodos(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                //quando o invocado, esse método cria o diálogo fora da árvore de componentes, então é necessário outro provider
                context: context,
                builder: (BuildContext context) {
                  return ChangeNotifierProvider<TodoController>.value(
                    // esse provider aproveita o valor já existente
                    value:
                        todoController, //que é o todoContoller fornecido pelo consumer
                    child: AddTodo(),
                  );
                },
              );
            },
            child: todoController.todoActive ==
                    null //se tem um todo ativo, altera ele, se não, insere um novo
                ? Icon(Icons.add)
                : Icon(Icons.edit),
          ),
        );
      },
    );
  }
}
