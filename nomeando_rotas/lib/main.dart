import 'package:flutter/material.dart';
import 'segunda_tela.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/segunda": (context) => const SegundaTela(),
    },
    home: const PrimeiraTela(),
  ));
}

class PrimeiraTela extends StatefulWidget {
  const PrimeiraTela({super.key});

  @override
  State<PrimeiraTela> createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text("Primeira Tela"),
      ),
      body:  Column(
        children: <Widget>[
          ElevatedButton(
            child: const Text("Ir para a segunda tela"),
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/segunda",
              );
            },
          ),
        ],
      ),
    );
  }
}
