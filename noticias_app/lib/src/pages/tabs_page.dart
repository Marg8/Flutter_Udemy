import 'package:flutter/material.dart';
import 'package:noticias_app/src/pages/tab1_page.dart';
import 'package:noticias_app/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';


class TabsPage extends StatelessWidget {  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>  new _NavigacionModel(),// instancia provider global
        child: Scaffold(
        body:_Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {

  


  @override
  Widget build(BuildContext context) {

    final navigacionModel = Provider.of<_NavigacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navigacionModel.paginaActual,
      onTap: (i) => navigacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Para ti"),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: "Encabezado")
      ],
      
    );
    
  }
}


class _Paginas extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavigacionModel>(context);
    
    return PageView(
      controller: navegacionModel.pageController,
       //physics: BouncingScrollPhysics(), //mover mendiante scroll lateral
      physics: NeverScrollableScrollPhysics(),// Mover mediante Botton
      children: [

        Tab1Page(),

        Tab2Page()
      ],
    );
  }

  
}

//provider
class _NavigacionModel with ChangeNotifier{

    int _paginaActual = 0;
    PageController _pageController = PageController(initialPage: 0);

    int get paginaActual => this._paginaActual;

    

    set paginaActual(int valor){
      this._paginaActual = valor;

      _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
      notifyListeners();
      
    }

    PageController get pageController => this._pageController;
    
    
  }

  