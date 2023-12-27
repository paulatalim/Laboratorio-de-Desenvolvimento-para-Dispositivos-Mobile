import './armazenamento.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(
      home: Home(),
    )
  );

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Armazenamento storage = Armazenamento();

  @override
  Widget build(BuildContext context) {
    TextEditingController controllernome = TextEditingController();
    TextEditingController controlleridade = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Banco de dados"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: "Digite o nome: ",
              ),
              controller: controllernome,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Digite a idade: ",
              ),
              controller: controlleridade,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    child: const Text("Salvar um usuário"),
                    onPressed: () {
                      storage.salvarDados(controllernome.text,
                          int.parse(controlleridade.text));
                    }),
                ElevatedButton(
                    child: const Text("Listar todos usuários"),
                    onPressed: () {
                      storage.listarUsuarios();
                    }),
                ElevatedButton(
                    child: const Text("Listar um usuário"),
                    onPressed: () {
                      storage.listarUmUsuario(2);
                    }),
                ElevatedButton(
                    child: const Text("Atualizar um usuário"),
                    onPressed: () {
                      storage.atualizarUsuario(2);
                    }),
                ElevatedButton(
                    child: const Text("Excluir usuário"),
                    onPressed: () {
                      storage.excluirUsuario(2);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
