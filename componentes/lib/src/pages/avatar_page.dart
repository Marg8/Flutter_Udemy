import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avatar Page"),
        actions: [

          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://cdn.mos.cms.futurecdn.net/EHjg4cc4XY9sNsrYYxNLuF.jpg"),
              radius: 25.0,
            ),
          ),
          
          Container(
            margin: EdgeInsets.only(right:10.0),
            child: CircleAvatar(
              child: Text("W"),
            backgroundColor: Colors.grey,
            ),
          ),
        ],
      ),
      body: Center(
        child: FadeInImage(
          image: NetworkImage("https://cdn.mos.cms.futurecdn.net/EHjg4cc4XY9sNsrYYxNLuF.jpg"),
          placeholder: AssetImage("assets/jar-loading.gif"),
          fadeOutDuration: Duration(milliseconds: 200),

        ),
      ),
      
    );
  }
}