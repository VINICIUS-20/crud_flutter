import 'package:crud/tarefa_model.dart';
import 'package:crud/tarefa_repository.dart';
import 'package:flutter/material.dart';

class EdicaoDeTarefa extends StatefulWidget {
  final Tarefa tarefa;
  final int index;

  EdicaoDeTarefa({required this.tarefa, required this.index});

  @override
  State<EdicaoDeTarefa> createState() => _EdicaoDeTarefaState();
}

class _EdicaoDeTarefaState extends State<EdicaoDeTarefa> {
  TextEditingController descricaoController = TextEditingController();

  TarefaBox tarefaBox = TarefaBox();

  @override
  void initState() {
    descricaoController.text = widget.tarefa.descricao.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar tarefa'),
      ),
      body: Column(
        children: [
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
                var atualizaTarefa = Tarefa(descricaoController.text);
                tarefaBox.editTarefa(widget.index, atualizaTarefa);
                setState(() {});
                Navigator.of(context).pop(atualizaTarefa);
              },
              child: Text('Salvar alterações'))
        ],
      ),
    );
  }
}
