import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _textoSalvo = "Nada salvo!";
  final TextEditingController _textController = TextEditingController();
  //o método será assincrono, ou seja, ao salvar os dados não necessariamente serão salvos de forma instantânea
  //executado de forma paralela
  _salvarDados() async{
    String valorDigitado = _textController.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", valorDigitado); // a chave será usada para recuperar dados
    debugPrint("Operação salvar: $valorDigitado");
  }
  _recuperarDados() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textoSalvo = prefs.getString("nome") ?? "Sem valor";
    });
    debugPrint("Operação recuperar: $_textoSalvo");
  }
  _removerDados() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");
    debugPrint("Operação remover");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Persistência de dados"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: "Digite o nome: ",
              ),
              controller: _textController,
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _salvarDados,
                  child: const Text("Salvar"),
                ),
                const SizedBox(width: 16,),
                ElevatedButton(
                  onPressed: _recuperarDados,
                  child: const Text("Recuperar"),
                ),
                const SizedBox(width: 16,),
                ElevatedButton(
                  onPressed: _removerDados,
                  child: const Text("Remover"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                ),
                Text(_textoSalvo,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
