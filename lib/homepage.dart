import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gamepage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
                child: Text("Start game"),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(
                      context, CupertinoPageRoute(builder: (_) => GamePage()));
                }),
            SizedBox(
              height: 40,
            ),
            CupertinoButton(
                child: Text("Exit Game"),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  exit(0);
                })
          ],
        ),
      ),
    );
  }
}
