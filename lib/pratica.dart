import 'package:consumo_servico_avancado/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Homeprtica extends StatefulWidget {
  const Homeprtica({Key? key}) : super(key: key);

  @override
  State<Homeprtica> createState() => _HomeState();
}
class _HomeState extends State<Homeprtica> {
 
  Future<List<Post>> _get() async {
   
   final urlDados = Uri.https(
          'jsonplaceholder.typicode.com', 
          '/posts');

    final Response = await http.get(urlDados);  
    
    List<Post> lista = [];
    var valores = json.decode(Response.body);
    for(var post in valores){
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      lista.add(p);
    }
    return lista;
 }

  Future<dynamic> _post() async{

    final urlPost = Uri.https(
      'jsonplaceholder.typicode.com', 
      '/posts');

      var conversao =  json.encode(
        {

          "userId": 120,
          "id": null,
          "title": "ANGOLA ESTÁ EM LUTO!!!",
          "body" : "FALECEU O ZÉ DÚ!!!"

        }
      );

      final Response = await http.post(
        urlPost,
        headers: {
              'Content-type': 'application/json; charset=UTF-8',

        },
        body: conversao,
        );
     
     print("Respostas: ${Response.statusCode.toString()}");
     print("Respostas: ${Response.body}");

  }

 Future<dynamic> _put() async{

    final urlPut = Uri.https(
      'jsonplaceholder.typicode.com', 
      '/posts/4');

      var conversao2 = json.encode(
        {

          "userId": 120,
          "id": null,
          "title": null,
          "body" : "FALECEU O ZÉ DÚ!!! Alterado"

        }
      );

      final Response = await http.put(
        urlPut,
        headers: {
           'Content-type': 'application/json; charset=UTF-8',
        },
        body: conversao2,

      );

       print("Respostas: ${Response.statusCode.toString()}");
       print("Respostas: ${Response.body}");
  }

  Future<dynamic> _patch() async{

    final urlPatch = Uri.https(
     'jsonplaceholder.typicode.com', 
      '/posts/4');

      var conversao3 = json.encode(
        {
          "userId": 120,
          "id": null,
          //"title": "ANGOLA ESTÁ EM LUTO!!! Alterado",
          "body" : "Ruben Manuel"
        }
      );

      final Response = await http.patch(
          urlPatch,
          headers: {
             'Content-type': 'application/json; charset=UTF-8',
          },
          body: conversao3,
        );

        print("Resposta: ${Response.statusCode.toString()}");
        print("Resposta: ${Response.body}");

  }


  Future<dynamic>_delete() async {
         
      final urlDelete= Uri.https(
        'jsonplaceholder.typicode.com', 
       '/posts/4');

      final Response = await http.delete(
        urlDelete
      );

      if(Response.statusCode.toString() == "200"){
        print("Foi deletado com sucesso!!!");
      }
      else{
        print("Infelizmente houve um erro!!!");
      }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 94, 206, 221),
      appBar: AppBar(
        title: Text("Consumo serviço web add na web"),
      ),
      body:Container(
        padding: EdgeInsets.all(18),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: () => _post(), 
                  child:Text("salvar"),
                  style: TextButton.styleFrom(backgroundColor: Colors.blue.shade900),
                  ),
                  TextButton(
                  onPressed: () => _patch(), 
                  child:Text("actualizar"),
                  style: TextButton.styleFrom(backgroundColor: Colors.blue.shade900),
                  ),
                  TextButton(
                  onPressed: () => _delete(), 
                  child:Text("delete"),
                  style: TextButton.styleFrom(backgroundColor: Colors.blue.shade900),
                  ),]),

           Expanded(
            child:FutureBuilder<List<Post>>(
            future: _get(),
            builder: (context, AsyncSnapshot snapshot){

          var result;

          switch(snapshot.connectionState){
            case ConnectionState.none:
            break;
            case ConnectionState.active:
            break;

            case ConnectionState.waiting:

            return Center(
              child: CircularProgressIndicator(color:Color.fromARGB(255, 77, 228, 228)),);

            case ConnectionState.done:
              if(snapshot.hasError){
               result = 'Erro ao conectar!!';
              }

              else{
                  result = ListView.builder(
                    itemCount: snapshot.data.toString().length,
                    itemBuilder: (context, index){
                    
                    List<Post> lista2 = snapshot.requireData;
                    Post post2 = lista2[index];
                        
                      return ListTile(
                        title: Text(post2.getid.toString()),
                        subtitle: Text(post2.gettile),
                      );
                      
                    });
              }
          }

          return result;

        }), ),
          
          ]),
      ) ,
    );
  }
}