import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Principal(title: 'Registrar Animal'),
    )
  );
}

class Principal extends StatefulWidget {
  const Principal({super.key, required this.title});

  final String title;

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Registrar o animal",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.italic)),
                  RegistrarAnimal(),
                ]),
          )),
    );
  }
}

class RegistrarAnimal extends StatefulWidget {
  const RegistrarAnimal({super.key});

  @override
  State<RegistrarAnimal> createState() => _RegistrarAnimalState();
}

class _RegistrarAnimalState extends State<RegistrarAnimal> {
  final _formKey = GlobalKey<FormState>();
  final listadePets = ["Gatos", "Cachorros", "Pássaros"];
  String? valorPadraoMenu = 'Cachorros';
  final nomeController = TextEditingController();
  final idadeController = TextEditingController();
  final dbRef = FirebaseDatabase.instance.ref().child("animais");

  @override
  void dispose() {
    super.dispose();
    idadeController.dispose();
    nomeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: "Digite o nome do animal",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite o nome:';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButtonFormField(
                  value: valorPadraoMenu,
                  icon: const Icon(Icons.arrow_downward),
                  decoration: InputDecoration(
                    labelText: "Selecione o tipo",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: listadePets.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      valorPadraoMenu = newValue;
                    });
                  },
                  validator: (dynamic value) {
                    if (value.isEmpty) {
                      return 'Favor selecionar o tipo';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: idadeController,
                  decoration: InputDecoration(
                    labelText: "Digite a idade",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Favor digitar a idade';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            dbRef.push().set({
                              "nome": nomeController.text,
                              "idade": idadeController.text,
                              "tipo": valorPadraoMenu
                            }).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Adicionado')));
                              idadeController.clear();
                              nomeController.clear();
                            }).catchError((onError) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(onError)));
                            });
                          }
                        },
                        child:const Text('Enviar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home(title: "Principal")),
                          );
                        },
                        child: const Text('Verificar'),
                      ),
                    ],
                  )),
            ])));
  }
}