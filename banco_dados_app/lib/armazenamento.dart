import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'dart:convert';

class Armazenamento {
  static Database? database;
  late String caminhoBancoDados;
  late String localBancoDados;

  Armazenamento() {
    if (database == null) {
      _initdatabase();
    }
  }

  void _initdatabase() async {
    caminhoBancoDados = await getDatabasesPath();
    localBancoDados = join(caminhoBancoDados, "banco3.db");
    database = await _recuperarBancoDados();
  }

  dynamic _recuperarBancoDados() async {
    // Codigo SQL para criar a tabela
    String conta = '''CREATE TABLE usuarios (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          nome VARCHAR, 
          idade INTEGER);''';

    // Abre e cria a tabela
    database = await openDatabase(localBancoDados, version: 1,
        onCreate: (database, databaseVersaoRecente) {
      database.execute(conta);
    });
    return database;
  }

  dynamic salvarDados(String nome, int idade) async {
    // Criptografa as informacoes sensiveis
    // var criptoEmail = criptografar(email);
    // var criptoSenha = criptografar(senha);

    // Adiciona as informacoes a um objeto
    Map<String, dynamic> dadosUsuario = {"nome": nome, "idade": idade};
    // Adiciona informacao no banco de dados
    int id = await database!.insert("usuarios", dadosUsuario);
    print("Salvo: $id ");
  }

  dynamic listarUsuarios() async {
    String sql = "SELECT * FROM usuarios";
    //String sql = "SELECT * FROM usuarios WHERE idade=58";
    //String sql = "SELECT * FROM usuarios WHERE idade >=30 AND idade <=58";
    //String sql = "SELECT * FROM usuarios WHERE idade BETWEEN 18 AND 58";
    //String sql = "SELECT * FROM usuarios WHERE nome='Maria Silva'";
    List usuarios = await database!
        .rawQuery(sql); //conseguimos escrever a query que quisermos
    for (var usu in usuarios) {
      print(
          " id: ${usu['id'].toString()} nome: ${usu['nome']} idade: ${usu['idade'].toString()}");
    }
  }

  dynamic listarUmUsuario(int id) async {
    List usuarios = await database!.query("usuarios",
        columns: ["id", "nome", "idade"], where: "id = ?", whereArgs: [id]);
    for (var usu in usuarios) {
      print(
          " id: ${usu['id'].toString()} nome: ${usu['nome']} idade: ${usu['idade'].toString()}");
    }
  }

  excluirUsuario(int id) async {
    int retorno = await database!.delete("usuarios",
        where: "id = ?", //caracter curinga
        whereArgs: [id]);
    print("Itens excluidos: " + retorno.toString());
  }

  dynamic atualizarUsuario(int id) async {
    Map<String, dynamic> dadosUsuario = {
      "nome": "Antonio Pedro",
      "idade": 35,
    };
    int retorno = await database!.update("usuarios", dadosUsuario,
        where: "id = ?", //caracter curinga
        whereArgs: [id]);
    print("Itens atualizados: " + retorno.toString());
  }

  /// Criptografa informacoes sensiveis
  dynamic criptografar(var atribute) {
    // Converte a varivel para string e depois para bytes
    var bytes = utf8.encode(atribute.toString());

    // Criptografa os bytes na criptografia MD5
    var digest = md5.convert(bytes);

    return digest;
  }

  /// Busca o usuario atraves do email e retorna seu id
  void buscarUsuario() {}
}
