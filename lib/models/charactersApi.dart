import 'package:http/http.dart' as http;

class characterApi {
  static Future getCharacters() async {
    return await http
        .get(Uri.parse("https://breakingbadapi.com/api/characters/"));
  }

  static Future getCharacterId(int id) async {
    return await http
        .get(Uri.parse("https://breakingbadapi.com/api/characters/$id"));
  }
}
