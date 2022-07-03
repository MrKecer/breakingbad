class Character {
  int? id;
  String? fullName;
  String? nick;
  String? status;
  String? imageUrl;
  String? birthday;
  String? category;

  Character(
      {this.id,
      this.fullName,
      this.nick,
      this.status,
      this.imageUrl,
      this.birthday,
      this.category});

  Character.formJson(Map json) {
    id = json["char_id"];
    fullName = json["name"];
    nick = json["nickname"];
    status = json["status"];
    imageUrl = json["img"];
    birthday = json["birthday"];
    category = json["category"];
  }

  @override
  String toString() {
    return 'Character(id: $id, fullName: $fullName, title: $nick, family: $status, imageUrl: $imageUrl,birthday:$birthday, category:$category)';
  }
}
