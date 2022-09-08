import 'package:consumo_servico_avancado/post_test_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class Hometest2 extends StatefulWidget {
  Hometest2({Key? key}) : super(key: key);

  @override
  State<Hometest2> createState() => _Hometest2State();
}

class _Hometest2State extends State<Hometest2> {

Future<List<PostTest2>> _get() async{

  final urlget = Uri.https(
    'jsonplaceholder.typicode.com', 
    '/posts');

  final Response = await http.get(urlget);

  var valores = json.decode(Response.body);

   List<PostTest2> lista = [];
  for(var valor in valores){
     PostTest2 postTest2 = PostTest2(valor["userId"], valor["id"], valor["title"], valor["body"]);
     lista.add(postTest2);
  }

  return lista;

}

Future<dynamic>_post() async{

  final urlPut = Uri.https(
    'jsonplaceholder.typicode.com', 
    '/posts');

    var conversao = json.encode(
      {
        "userId": 101,
        "ïd": null,
        "title": "OS BELOS!",
        "body":"Ruben Manuel",

      }
    );

  final Response = await http.post(
    urlPut,
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
    },
    body: conversao,

  );

  print("Resposta: ${Response.body}");
  print("Resposta: ${Response.statusCode.toString()}");

}

Future<dynamic> _put() async{

  final urlPut = Uri.https(
    'jsonplaceholder.typicode.com', 
    '/posts/2'
  );

   var conversao2 = json.encode(
    {
        "userId": 101,
        "ïd": null,
        "title": "Hello Word!",
        "body":"Programacao",
    }
   );

  final Response = await http.put(
    urlPut,
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
    },
    body: conversao2,
  );

  print("Resposta: ${Response.body}");
  print("Resposta: ${Response.statusCode.toString()}");

}

Future<dynamic> _patch() async {


  final urlPatch = Uri.https(
    'jsonplaceholder.typicode.com', 
    '/posts/2'
  );

  var conversao3 = json.encode(
    {
       "userId": 101,
        "ïd": null,
        "title": "Hello Angola!",
       
    }
  );
  final Response = await http.patch(
    urlPatch,
    headers:{
       'Content-type': 'application/json; charset=UTF-8',
    },
    body: conversao3,
  );

  print("Resposta: ${Response.body}");
  print("Resposta: ${Response.statusCode.toString()}");

}

Future<dynamic>_delete() async{

  final urlDelete = Uri.https(
   'jsonplaceholder.typicode.com', 
   '/posts/2');
   
  final Response = await http.delete(
    urlDelete
  );

  if(Response.statusCode.toString() == "200"){
    print("O elemento foi eliminado com sucesso!");
  }
  else{
    print("O elemento nãofoi eliminado!!!");
  }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 180, 107),
      appBar: AppBar(
title: Text("Requisição Get, Post, Put, Patch e Delete."),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: 
        Column(
          children: <Widget>[
            Row(children: [
              TextButton(
                onPressed: () => _post(),
                 child: Text("salvar", style: TextStyle(
                  color: Colors.white
                 ),),
                 style: TextButton.styleFrom(backgroundColor: Color.fromARGB(255, 56, 216, 42)),),
                 TextButton(
                onPressed: () => _put(),
                 child: Text("actPut", style: TextStyle(
                  color: Colors.white
                 ),),
                 style: TextButton.styleFrom(backgroundColor: Color.fromARGB(255, 250, 174, 9)),),
                 TextButton(
                onPressed: () => _patch(),
                 child: Text("actPatch", style: TextStyle(
                  color: Colors.white
                 ),),
                 style: TextButton.styleFrom(backgroundColor: Color.fromARGB(255, 217, 238, 29)),),
                 TextButton(
                onPressed: () => _delete(),
                 child: Text("apagar", style: TextStyle(
                  color: Colors.white
                 ),),
                 style: TextButton.styleFrom(backgroundColor: Color.fromARGB(255, 252, 16, 28)),)

            ],),
            Expanded(child: FutureBuilder<List<PostTest2>>(
              future: _get(),
              builder: (BuildContext context, AsyncSnapshot snapshot){

                var listafinal;

                 switch(snapshot.connectionState){

                  case ConnectionState.none:
                  break;

                  case ConnectionState.active:
                  break;

                  case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator(backgroundColor: Colors.blue),);
                  break;

                  case ConnectionState.done:
                     if(snapshot.hasError){
                       print("A conexão não teve exito!");
                     }
                     else{

                      listafinal = ListView.builder(
                        itemCount: snapshot.data,
                        itemBuilder: (context, index){
                    
                        List<PostTest2>  lista = [];
                        PostTest2 post = lista[index];
  
                        return ListTile(
                          title: Text(post.getTitle),
                          subtitle: Text(post.getBody) ,
                        );

                        });
   
                     }
                  break;

                 }
                  return listafinal;
              }
              
              ))
          ],
        ),
      ),
    );
  }
}