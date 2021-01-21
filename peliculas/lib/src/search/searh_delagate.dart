import 'package:flutter/material.dart';
import 'package:peliculas/src/modelos/pelicula_modelo.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  String seleccion = "";
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    "Spiderman",
    "Hulk",
    "Iron Man",
    "Wolverine",
    "Capitan america",
    "Thor",
    "Magneto",
    "Cilcope",
    "Ice Man"
  ];

  final peliculasRecientes = [
    "Spiderman",
    "Ice Man"
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
      // Acciones del  serachbox
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = "";
          },
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // icono a la izquierda de srachbox     
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
          ),
          onPressed: (){
            close(context, null);
          },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // crea los resultados
      return Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.blueAccent,
          child: Text(seleccion),
        ),
      );
    }

    @override
    Widget buildSuggestions(BuildContext context) {
      // las sugerencias al escribir en searchbox

      if(query.isEmpty){
        return Container();
      }

      return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {

          if(snapshot.hasData){
            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map((pelicula){
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage("assets/images/no-image.jpg"), 
                    image: NetworkImage(pelicula.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.contain,
                    ),
                    title: Text(pelicula.title),
                    subtitle: Text(pelicula.originalTitle),
                    onTap: (){
                      close(context, null);
                      pelicula.uniqueId = "";
                      Navigator.pushNamed(context, "detalle", arguments: pelicula);
                    },
                );
              }).toList()
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          
        },
      );

    }
  
    /*@override
    Widget buildSuggestions(BuildContext context) {
    // las sugerencias al escribir en searchbox
    final listaSugerida = (query.isEmpty) 
                          ? peliculasRecientes 
                          : peliculas.where(
                          (p) => p.toLowerCase().startsWith(query.toLowerCase())
                          ).toList();

      return ListView.builder( 
      itemCount: listaSugerida.length,
      itemBuilder: (context, i){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: (){
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
      }
    );
  }*/

}