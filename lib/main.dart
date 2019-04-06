import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'dart:convert';
import 'package:emoji_hand_book/emoji.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

void main() {
  runApp(MaterialApp(home: HomeWidget()));
}

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmojiListState();
  }
}

class EmojiListState extends State<HomeWidget> {
  var parser = EmojiParser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Emoji Hand Book"), backgroundColor: Color(0xFFFDD835)),
        body: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/emoji.json'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var jsonData = jsonDecode(snapshot.data);
                EmojiList emojis = EmojiList.fromJson(jsonData);
                return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      var emojiInfo = parser.get(emojis.datas[index].text);
                      return GestureDetector(
                          onTap: () {
                            ClipboardManager.copyToClipBoard(
                                    emojis.datas[index].text)
                                .then((result) {
                              final snackBar = SnackBar(
                                content: Text('Copied to Clipboard'),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                                emojiInfo.code + " " + emojis.datas[index].text,
                                style: TextStyle(fontSize: 20)),
                          ));
                    },
                    itemCount: emojis.datas.length);
              } else {
                return Center(child: new CircularProgressIndicator());
              }
            }));
  }
}
