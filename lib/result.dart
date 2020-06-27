import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sps_app/homepage.dart';

class ResultPage extends StatefulWidget {
  String winner;
  ResultPage({Key key, this.winner}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  @override
  void initState() { 
    super.initState();
    Future.delayed(Duration(seconds: 4),mainPage);
  }

  mainPage(){
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>HomePage()));
  }
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(  
      body: Center(
        child:Container(
          padding:EdgeInsets.all(16.0),
          height:screenHeight * 0.3,
          width: screenWidth * 0.6,
          color: Theme.of(context).primaryColor,
          child: widget.winner == "player" ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Hurray!!", style: TextStyle(color:Colors.white, fontSize:24.0, fontWeight: FontWeight.bold),),
              Text("You won the Game",style: TextStyle(color:Colors.white, fontSize:20.0),)
            ],
          ):Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Sorry",style: TextStyle(color:Colors.white, fontSize:24.0, fontWeight: FontWeight.bold),),
              Text("You Lost",style: TextStyle(color:Colors.white, fontSize:20.0),)
            ],
          ),
        ),
      ),
    );
  }
}