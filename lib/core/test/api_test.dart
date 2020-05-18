import 'package:flutter_test/flutter_test.dart';
import 'package:hive_local_storage/core/services/api.dart';

void main() {
  test("api test", () async {
    ApiService service = ApiService();
    var comments = await service.getComments();
    print(comments.first.name);
  });
}
