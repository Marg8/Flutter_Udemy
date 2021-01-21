import 'package:flutter/material.dart';
import 'package:peliculas/src/modelos/pelicula_modelo.dart';

class MovieHorizontal extends StatelessWidget {

final List<Pelicula> peliculas;
final Function siguientePagina;

MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

final _pageController = new PageController(
  initialPage: 1,
  viewportFraction: 0.3
);

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size; 

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent){
        //llama la carga de nuevas paginas
        siguientePagina();

      }
     });

    return Container(
      height: _screenSize.height * 0.23,
      child:PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i){
          return _tarjeta1(context, peliculas[i]);
        }
        ),
    );
  }

  Widget _tarjeta1(BuildContext context, Pelicula pelicula){

    pelicula.uniqueId = "${pelicula.id}-poster";

    final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children:<Widget> [
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage("assets/images/no-image.jpg"), 
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 159.0,
                  ),
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
             
            )
          ],
        ),

    );
    return GestureDetector(
      child: tarjeta,
      onTap: (){
        Navigator.pushNamed(context, "detalle", arguments: pelicula);
      },
    );
    
  }

  List<Widget> _tarjetas(context) {

    return peliculas.map( (pelicula) {

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children:<Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage("assets/images/no-image.jpg"), 
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 159.0,
                ),
            ),
            SizedBox(height: 5.0,),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
             
            )
          ],
        ),

    );

    }).toList();
         

  }
}