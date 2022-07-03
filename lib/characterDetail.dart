import 'dart:convert';
import 'package:breakingbad/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:breakingbad/models/charactersApi.dart';

class characterDetail extends StatefulWidget {
  late int id;
  characterDetail(int id) {
    this.id = id;
  }

  @override
  State<characterDetail> createState() => _characterDetailState();
}

class _characterDetailState extends State<characterDetail> {
  List<Character> charactersD = [];
  Character c = Character();
  bool loading = false;

  @override
  void initState() {
    getCharactersApi();
  }

  @override
  Widget build(BuildContext context) {
    return loading == false
        ? Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/old.jpg"), fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                  child: SpinKitPouringHourGlass(
                size: 70,
                color: Colors.deepOrangeAccent,
              )),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/old.jpg"), fit: BoxFit.cover)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: AnimatedTextKit(
                    repeatForever: true,
                    stopPauseOnTap: true,
                    onTap: () {},
                    animatedTexts: [
                      TyperAnimatedText(
                        charactersD[0].fullName!,
                        speed: Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                ),
                body: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0),
                                  blurRadius: 9,
                                  spreadRadius: 3,
                                )
                              ],
                              image: DecorationImage(
                                image: NetworkImage(charactersD[0].imageUrl!),
                                fit: BoxFit.fill,
                              )),
                          height: 200,
                          width: 150,
                        ),
                      ),
                      ListTile(
                        // contentPadding: EdgeInsets.only(left: 20),
                        leading: Text(
                          "Nick Name: ",
                          style: TextStyle(
                              fontSize: 19, color: Colors.blueGrey.shade900),
                        ),
                        title: Text(
                          charactersD[0].nick!,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          "Full Name: ",
                          style: TextStyle(
                              fontSize: 19, color: Colors.blueGrey.shade900),
                        ),
                        title: Text(
                          charactersD[0].fullName!,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          "Birthday: ",
                          style: TextStyle(
                              fontSize: 19, color: Colors.blueGrey.shade900),
                        ),
                        title: Text(
                          charactersD[0].birthday!,
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          "Status: ",
                          style: TextStyle(
                              fontSize: 19, color: Colors.blueGrey.shade900),
                        ),
                        title: Align(
                          alignment: Alignment(-1, 0),
                          child: Text(
                            charactersD[0].status!,
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          "Series: ",
                          style: TextStyle(
                              fontSize: 19, color: Colors.blueGrey.shade900),
                        ),
                        title: Align(
                          alignment: Alignment(-1, 0),
                          child: Text(
                            charactersD[0].category!,
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
  }

  void getCharactersApi() {
    characterApi.getCharacterId(widget.id).then((value) {
      setState(() {
        Iterable list = jsonDecode(value.body);
        this.charactersD = list.map((e) => Character.formJson(e)).toList();
        loading = true;
      });
    });
  }
}
