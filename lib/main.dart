import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:breakingbad/models/charactersApi.dart';
import 'characterDetail.dart';
import 'models/characters.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Breaking Bad",
      debugShowCheckedModeBanner: false,
      home: characterScreen(),
    );
  }
}

class characterScreen extends StatefulWidget {
  const characterScreen({Key? key}) : super(key: key);

  @override
  State<characterScreen> createState() => _characterScreenState();
}

class _characterScreenState extends State<characterScreen> {
  List<Character> characters = [];
  List<Widget> characterWidget = [];

  @override
  void initState() {
    getCharactersApi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.deepOrange.shade400,
        Colors.yellow.shade600,
        Colors.deepOrange.shade400,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(Icons.science),
          titleSpacing: 0,
          title: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(
                'Breaking Bad',
                textStyle: TextStyle(shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  )
                ]),
                speed: Duration(milliseconds: 2000),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: characterWidget,
          ),
        ),
      ),
    );
  }

  void getCharactersApi() {
    characterApi.getCharacters().then((value) {
      setState(() {
        Iterable list = jsonDecode(value.body);
        this.characters = list.map((e) => Character.formJson(e)).toList();
        getCategoryWidget();
      });
    });
  }

  List<Widget> getCategoryWidget() {
    for (var i = 0; i < characters.length; i++) {
      characterWidget.add(getCharatersItems(characters[i]));
    }
    return characterWidget;
  }

  Widget getCharatersItems(Character character) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.deepOrangeAccent,
      ),
      child: ListTile(
        leading: CircleAvatar(
          //radius: 10,
          backgroundImage: NetworkImage(
            character.imageUrl!,
          ),
        ),
        title: Text(
          character.fullName!,
          style: TextStyle(fontSize: 18, shadows: [
            Shadow(
              blurRadius: 8.0,
              color: Colors.black45,
              offset: Offset(0, 0),
            )
          ]),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => characterDetail(character.id!),
            ),
          );
        },
      ),
    );
  }
}
