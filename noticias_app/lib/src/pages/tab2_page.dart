import "package:flutter/material.dart";
import 'package:noticias_app/src/models/category_mdoel.dart';
import 'package:noticias_app/src/services/news_services.dart';
import 'package:noticias_app/src/widgets/litsa_noticias.dart';
import 'package:noticias_app/theme/tema.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);  

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [

            _ListaCategorias(),

            if ( !newsService.isLoading )
              Expanded(
                child: ListaNoticias( newsService.getArticulosCategoriasSelecionada )
              ),

            if ( newsService.isLoading )
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              )
            )

            //Expanded(child: (newsService.getArticulosCategoriasSelecionada.length == 0)
            //? Center(child: CircularProgressIndicator())
            //: ListaNoticias(newsService.getArticulosCategoriasSelecionada))
            
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){

          final cName = categories[index].name;

        return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryBotton(categories[index]),
                SizedBox(height: 5),
                Text("${cName[0].toUpperCase()}${cName.substring(1)}"),
              ],
            ),
            
        );  

        }
      ),
    );
  }
}

class _CategoryBotton extends StatelessWidget {
  
  final Category categoria;

  const _CategoryBotton(this.categoria);
  

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    
    return GestureDetector(
      onTap: (){
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
        
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == this.categoria.name)
               ? miTema.accentColor
               : Colors.black54,
        ),
      ),
    );
  }
}