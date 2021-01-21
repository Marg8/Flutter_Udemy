import 'package:flutter/material.dart';
import 'package:noticias_app/src/models/news_models.dart';
import 'package:noticias_app/theme/tema.dart';

class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;

  const ListaNoticias(this.noticias);
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index){
        return _Noticia(noticia: this.noticias[index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({
    @required this.noticia,
    @required this.index
  });




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticia, index),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia),
        _TarjetaBody(noticia),

        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}

//Tarjetas
class _TarjetaBody extends StatelessWidget {

  final Article noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Text((noticia.description != null) ? noticia.description : "Sin detalles de esta Noticia"),
    );
  }
}


class _TarjetaImagen extends StatelessWidget {

  final Article noticia;

  const _TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),    
        child: (noticia.urlToImage != null)
        ? FadeInImage(
          placeholder: AssetImage("assets/img/giphy.gif"),
          image: NetworkImage(noticia.urlToImage),
        )
        : Image(image: AssetImage("assets/img/no-image/png"),)
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {

  final Article noticia;
 

  const _TarjetaTitulo(this.noticia); 
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    );
  }
}



class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _TarjetaTopBar(this.noticia, this.index); 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text("${index + 1}", style: TextStyle(color: miTema.accentColor),),
          Text("${noticia.source.name}."),

        ],),
    );
  }
}