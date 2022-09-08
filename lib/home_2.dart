import 'package:consumo_servico_avancado/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home2 extends StatefulWidget {
  Home2({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}
class _Home2State extends State<Home2> {
  
   //final _urlBase = "https://jsonplaceholder.typicode.com";   

    Future<List<Post>> _recuperarPostagens() async{
      
        final urlPost = Uri.https(
          'jsonplaceholder.typicode.com', 
          '/posts');

          final Responde = await http.get(urlPost);

          var listas = json.decode(Responde.body); 
          
          List<Post> postagens =[];
          for(var post in listas){
            Post p = Post(post["id"], post["albumId"], post["title"], post["url"]);
            postagens.add(p);
          }
          return postagens;

    }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 176, 228, 248),
      appBar: AppBar(
        title: Text("Consumo de dados da Web"),
      ),
      body: FutureBuilder<List<Post>>(
      future: _recuperarPostagens(),
      builder: ( context, snapshot){

        var r;

         switch(snapshot.connectionState){
          case ConnectionState.none: 
            print("Conexão none");
          break;

          case ConnectionState.waiting:
            return  Center(child: CircularProgressIndicator(
              color: Color.fromARGB(255, 3, 238, 23),
            ),);
          break;

          case ConnectionState.active:

          case ConnectionState.done:
            if(snapshot.hasError){
             print("Lista: Erro ao carregar");
            }
            else{
              print("Lista: Carregou!!");
             
                 r = ListView.builder(
                itemCount: snapshot.data.toString().length,
                itemBuilder: (context, index){

                  List<Post> lista = snapshot.requireData;
                  Post post = lista[index];
                  print(post); 


                  return ListTile(
                    title: Text(post.gettile),
                    subtitle: Text(post.getid.toString()),
                  );
                  
                }
                );
              
            }
          break;
           
        }
        return r;
      }),
    );
  }
}