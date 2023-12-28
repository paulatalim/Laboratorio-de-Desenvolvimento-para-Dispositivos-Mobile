import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _itens = [];

  void _carregarItens(){
    _itens = [];
    for(int i=0; i<=10; i++){
      Map<String, dynamic> item = <String, dynamic>{};
      item["titulo"] = "Titulo $i da lista";
      item["descricao"]="Descrição $i da lista";
      _itens.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    _carregarItens();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: _itens.length,
            itemBuilder: (context, indice) {
              //print("item ${indice}");
              //Map<String, dynamic> item =_itens[indice];
              //print("item ${_itens[indice]["titulo"]}");
              return ListTile(
                onTap: (){
                  //print("Clique com onTap ${indice}");
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text(_itens[indice]["titulo"]),
                          titleTextStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            backgroundColor: Colors.yellow,
                          ),
                          content: Text(_itens[indice]["descricao"]),
                          actions: <Widget>[ //definir widgets
                            TextButton(
                                onPressed: (){
                                  debugPrint("Selecionado sim");
                                  Navigator.pop(context);
                                },
                                child: const Text("Sim")
                            ),
                            TextButton(
                                onPressed: (){
                                  debugPrint("Selecionado não");
                                  Navigator.pop(context);
                                },
                                child: const Text("Não")
                            ),
                          ],
                        );
                      }
                  );
                },
                onLongPress: (){
                  //print("Clique com onLongPress ${indice}");
                },
                title: Text(_itens[indice]["titulo"]),
                subtitle: Text(_itens[indice]["descricao"]),
              );
            }
        ),
      ),
    );
  }
}
