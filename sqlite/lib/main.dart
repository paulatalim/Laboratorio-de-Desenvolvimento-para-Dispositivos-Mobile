import './armazenamento.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Armazenamento storage = Armazenamento();

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllernome = TextEditingController();
    TextEditingController _controlleridade = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Banco de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Digite o nome: ",
              ),
              controller: _controllernome,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Digite a idade: ",
              ),
              controller: _controlleridade,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    child: Text("Salvar um usuário"),
                    onPressed: () {
                      storage.salvarDados(_controllernome.text,
                          int.parse(_controlleridade.text));
                    }),
                ElevatedButton(
                    child: Text("Listar todos usuários"),
                    onPressed: () {
                      storage.listarUsuarios();
                    }),
                ElevatedButton(
                    child: Text("Listar um usuário"),
                    onPressed: () {
                      storage.listarUmUsuario(2);
                    }),
                ElevatedButton(
                    child: Text("Atualizar um usuário"),
                    onPressed: () {
                      storage.atualizarUsuario(2);
                    }),
                ElevatedButton(
                    child: Text("Excluir usuário"),
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
