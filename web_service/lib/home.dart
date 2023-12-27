import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controllercep = TextEditingController();
  String _resultado = "Resultado";

  _recuperaCep() async {
    String cepDigitado = _controllercep.text;
    var uri = Uri.parse("https://viacep.com.br/ws/$cepDigitado/json/");
    http.Response response;
    response = await http.get(uri);
    Map<String, dynamic> retorno = json.decode(response.body);
    if (retorno["logradouro"] != null) {
      String logradouro = retorno["logradouro"];
      String complemento = retorno["complemento"];
      String bairro = retorno["bairro"];
      String localidade = retorno["localidade"];
      setState(() { //configurar o _resultado
        _resultado = "$logradouro, $complemento, $bairro, $localidade";
      });
    } else {
      setState(() { //configurar o _resultado
        _resultado = "Não encontrado";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consumo de serviço web"),
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Digite o cep ex: 30360190"
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
              controller: _controllercep,
            ),
            ElevatedButton(
                onPressed: _recuperaCep,
                child: const Text("Clique aqui"),
            ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
