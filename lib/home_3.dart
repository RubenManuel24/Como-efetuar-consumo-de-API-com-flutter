import 'package:consumo_servico_avancado/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
 
  Future<List<Post>> _carregarServico() async {
   
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


 Future<dynamic>_post() async {

  final urlDados = Uri.https(
          'jsonplaceholder.typicode.com', 
          '/photos');

          var valor2 = json.encode(
                  {
          "userId": 120,
          "id": null,
          "title": "Angola",
          "body": "titulo",
          },  
          );

   final Response = await  http.post(
    urlDados ,
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
    },
    body: valor2,
    
    );

    print("Respostas: ${Response.body}");
 }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 94, 206, 221),
      appBar: AppBar(
        title: Text("Consumo serviço web add na web"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                TextButton(
                  onPressed: () => _post(), 
                  child: Text("salvar"),
                  style: TextButton.styleFrom(backgroundColor: Colors.amber),
                  ),

                  TextButton(
                  onPressed: () => _post(),  
                  child: Text("Atualizar"),
                  style: TextButton.styleFrom(backgroundColor: Colors.amber),
                  ),

                  TextButton(
                  onPressed: () => _post(),  
                  child: Text("Remover"),
                  style: TextButton.styleFrom(backgroundColor: Colors.amber),
                  ),
                  
              ],),

          Expanded(child: FutureBuilder<List<Post>>(
        future: _carregarServico(),
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


        }),),
              
          ]),
      ),
    );
  }
}