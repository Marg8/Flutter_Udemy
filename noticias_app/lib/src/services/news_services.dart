
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticias_app/src/models/category_mdoel.dart';
import 'package:noticias_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = "https://newsapi.org/v2";
final _APIKEY = "3d23610fbc734294b364c48b4a2fe553";

class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = "business";

  bool _isLoading = true;

  List<Category> categories =[

    Category(FontAwesomeIcons.building, "business"),
    Category(FontAwesomeIcons.tv, "entertainment"),
    Category(FontAwesomeIcons.addressCard, "general"),
    Category(FontAwesomeIcons.headSideVirus, "health"),
    Category(FontAwesomeIcons.vials, "science"),
    Category(FontAwesomeIcons.volleyballBall, "sports"),
    Category(FontAwesomeIcons.memory, "technology"),
    
      
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService(){
    
    this.getTopHeadLines();

    categories.forEach((item) {
      this.categoryArticles[item.name] = new List<Article>.empty(growable: true);
     });

     this.getArticleByCategory( this._selectedCategory );

  }

  bool get isLoading => this._isLoading;

  

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor){
    this._selectedCategory = valor;

    this._isLoading = true;
    this.getArticleByCategory(valor);
    notifyListeners();
  }
  
  List<Article> get getArticulosCategoriasSelecionada => this.categoryArticles[this.selectedCategory];

  


  getTopHeadLines() async{

    final url = "$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us";
    final resp = await http.get(url);

    final newsResponce = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponce.articles);
    notifyListeners();
  }

  getArticleByCategory(String category) async{

    if(this.categoryArticles[category].length > 0){
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }

    final url ="$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category";
    final resp = await http.get(url);

    final newsResponce = newsResponseFromJson(resp.body);

    this.categoryArticles[category].addAll(newsResponce.articles);

    this._isLoading = false;
    notifyListeners();
  }

  
  
}