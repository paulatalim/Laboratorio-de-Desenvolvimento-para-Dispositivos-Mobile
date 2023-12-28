import 'package:flutter/material.dart';

class SegundaTela extends StatefulWidget {
  const SegundaTela({super.key});

  @override
  State<SegundaTela> createState() => _SegundaTelaState();
}

class _SegundaTelaState extends State<SegundaTela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Segunda Tela"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            const Text("Você está na segunda tela"),
            ElevatedButton(
              child: const Text("voltar para a primeira tela"),
              onPressed: (){
                Navigator.pushNamed(
                    context,
                    "/",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
