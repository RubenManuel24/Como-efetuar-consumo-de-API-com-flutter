import 'package:flutter/material.dart';
import 'package:http/http.dart' as htt;
import 'dart:convert';
import 'dart:async';
class Home1 extends StatefulWidget {
  Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _HomeState();
}

class _HomeState extends State<Home1> {
   Future<Map> _carregarDados() async {

    final urlApi = Uri.https(
      'blockchain.info', 
        '/ticker');
    final Response = await htt.get(urlApi);
    
    return json.decode(Response.body);

  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map>(
      future: _carregarDados(),
      builder: ( BuildContext context, AsyncSnapshot snapshot ){

          String _resultado = "";

          switch(snapshot.connectionState){
          case ConnectionState.none : 
            print("Conexão none");
          break;

          case ConnectionState.active :
            print("Conexão active");
          break;

          case ConnectionState.done :
            print("Conexão done");
            if(snapshot.hasError){
              _resultado = "Erro ao conectar-se!";
            }
            else{
                double valor = snapshot.data["BRL"]["buy"];
                _resultado = "Preço do Bitcoin: ${valor.toString()}";
            }
          break;

          case ConnectionState.waiting :
            print("Conexão waiting");
            _resultado ="Carregando...";
          break;

          }
          return Center(
            child: Text(_resultado),
          );
      });
  }
}