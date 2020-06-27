import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'result.dart';

var playerChoice;

class GamePage extends StatefulWidget {
  GamePage({Key key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> computerOptions = ["stone", "paper", "scissor"];

  final _computerChoice = new Random();
  var compChoice;
  int playerScore, computerScore;

  @override
  void initState() {
    super.initState();
    playerScore = 0;
    computerScore = 0;
  }

  computeOption() {
    setState(() {
      compChoice =
        computerOptions[_computerChoice.nextInt(computerOptions.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: GestureDetector(
                  child: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 60.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ScoreCardWidget(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    scoreCardName: "Player Score",
                    scoreCardPoints: playerScore,
                  ),
                  ScoreCardWidget(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    scoreCardName: "Player Score",
                    scoreCardPoints: computerScore,
                  ),
                ],
              ),
              SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SelectionDisplayWidget(textToShow: "You selected\n $playerChoice",),
                  SelectionDisplayWidget(textToShow: "Sys selected\n $compChoice",)
                ],
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PlayerSelectionButton(
                    optionName: "Stone",
                    onPressed: stone,
                  ),
                  PlayerSelectionButton(
                    optionName: "Paper",
                    onPressed: paper,
                  ),
                  PlayerSelectionButton(
                    optionName: "Scissor",
                    onPressed: scissor,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  validation(){
    if(playerChoice == compChoice){
      Toast.show("Draw", context,duration:Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }else if(playerChoice == "stone"){
      if(compChoice == "paper"){
        setState(() {
          computerScore = computerScore + 1;
        });
        Toast.show("Computer Got 1 Point", context,duration:Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }else if(compChoice == "scissor"){
        setState(() {
          playerScore = playerScore + 1;
        });
        Toast.show("You Got 1 Point", context,duration:Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }else if(playerChoice == "paper"){
      if(compChoice == "scissor"){
        setState(() {
          computerScore = computerScore + 1;
        });
        Toast.show("Computer Got 1 Point", context,duration:Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }else if(compChoice == "stone"){
        setState(() {
          playerScore = playerScore + 1;
        });
        Toast.show("You Got 1 Point", context,duration:Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }else if(playerChoice == "scissor"){
      if(compChoice == "stone"){
        setState(() {
          computerScore = computerScore + 1;
        });
        Toast.show("Computer Got 1 Point", context,duration:Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }else if(compChoice == "paper"){
        setState(() {
          playerScore = playerScore + 1;
        });
        Toast.show("You Got 1 Point", context,duration:Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }

    if(playerScore == 10){
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>ResultPage(winner: "player")));
    }else if(computerScore == 10){
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>ResultPage(winner: "computer")));
    }
  }

  stone() {
    setState(() {
      playerChoice = "stone";
    });
    computeOption();
    validation();
  }

  paper() {
    setState(() {
      playerChoice = "paper";
    });
    computeOption();
    validation();
  }

  scissor() {
    setState(() {
      playerChoice = "scissor";
    });
    computeOption();
    validation();
  }
}

class SelectionDisplayWidget extends StatelessWidget {
  String textToShow;
  SelectionDisplayWidget({
    Key key,
    this.textToShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin:
          EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      decoration: BoxDecoration(color: Colors.grey),
      child: playerChoice == null
          ? Text(
              "Start The \ngame",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontSize: 20.0),
            )
          : Text(
              textToShow,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontSize: 20.0),
            ),
    );
  }
}

class PlayerSelectionButton extends StatelessWidget {
  String optionName;
  Function onPressed;
  PlayerSelectionButton({Key key, this.optionName, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.0)),
      child: FlatButton(
          onPressed: onPressed,
          child: Text(
            optionName,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          color: Theme.of(context).primaryColor),
    );
  }
}

class ScoreCardWidget extends StatelessWidget {
  String scoreCardName;
  int scoreCardPoints;
  ScoreCardWidget(
      {Key key,
      @required this.screenHeight,
      @required this.screenWidth,
      this.scoreCardName,
      this.scoreCardPoints})
      : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenHeight * 0.175,
        width: screenWidth * 0.4,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              scoreCardName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            Text(
              scoreCardPoints.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ],
        ));
  }
}
