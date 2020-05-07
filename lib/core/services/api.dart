import 'package:hive_local_storage/core/models/commens.dart';
import '../consts/consts.dart' as cons;
import 'package:http/http.dart' as http;

class ApiService {

  Future<List<Comments>> getComments() async {
    List<Comments> comments = List<Comments>();
    final response = await http.get(cons.API_URL);
    try {
      if (response.statusCode == 200) {
        comments = commentsFromJson(response.body.toString());
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      return List<Comments>();
    }
    return comments;
  }
}
