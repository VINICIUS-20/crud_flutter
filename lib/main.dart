import 'package:crud/editar_tarefa.dart';
import 'package:crud/tarefa_model.dart';
import 'package:crud/tarefa_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TarefaAdapter());
  await Hive.openBox<Tarefa>('tarefa');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController descricaoController = TextEditingController();
  TarefaBox tarefaBox = TarefaBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar tarefa')),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: TextField(
            controller: descricaoController,
            decoration: InputDecoration(
              label: Text('Descrição'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              var novaTarefa = Tarefa(descricaoController.text);
              tarefaBox.addTarefa(novaTarefa);
              setState(() {
                descricaoController.clear();
              });
            },
            child: Text('Salvar alterações')),
        Expanded(
            child: ListView.builder(
          itemCount: tarefaBox.mostrarTarefas().length,
          itemBuilder: (context, index) {
            var tarefa = tarefaBox.mostrarTarefas()[index];
            return ListTile(
              title: Text(tarefa.descricao ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      tarefaBox.deletarTarefa(index);
                      setState(() {});
                    },
                    icon: Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () async {
                      var result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              EdicaoDeTarefa(tarefa: tarefa, index: index),
                        ),
                      );
                      if (result != null) {
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.edit_outlined),
                  ),
                ],
              ),
            );
          },
        ))
      ]),
    );
  }
}
