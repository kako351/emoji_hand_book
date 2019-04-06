class Emoji {
  Emoji({this.text});

  String text;

  factory Emoji.fromJson(Map<String, dynamic> json) {
    return Emoji(text: json['text'] as String);
  }

  Map<String, dynamic> toJson() => {'text': text};
}

class EmojiList {
  final List<Emoji> datas;

  EmojiList({this.datas});

  factory EmojiList.fromJson(List<dynamic> json) {
    List<Emoji> datas = new List<Emoji>();
    datas = json.map((i) => Emoji.fromJson(i)).toList();

    return EmojiList(datas: datas);
  }
}
