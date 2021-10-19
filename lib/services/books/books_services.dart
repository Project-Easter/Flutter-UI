
import 'package:books_app/config/api.dart';
import 'package:books_app/services/base/base_services.dart';

class BooksServices extends BaseServices {

  Future<Map<String, dynamic>?> getBooksbyISBN(String isbn) async {
    final Map<String, dynamic>? data = await getAPI('$baseHost?q=isbn$isbn');
    return data;
  }

  Future<Map<String, dynamic>?> getTop() async {
    final Map<String, dynamic>? data = await getAPI('$baseHost?q=isbn');
    return data;
  }

  Future<Map<String, dynamic>?> search(String name) async {
    final Map<String, dynamic>? data = await getAPI('$baseHost?q=$name');
    return data;
  }

}