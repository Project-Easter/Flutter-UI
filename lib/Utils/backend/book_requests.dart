import 'package:books_app/Utils/helpers.dart';
import 'package:books_app/constants/api.dart';
import 'package:http/http.dart';

class BookRequest {

  static Future<Response> bookDataFromISBN(String token, String isbn) async {
    return sendRequest(() => get(Uri.parse(BASE_ROUTE + '/user/data'),
        headers: <String, String>{'authorization': token, 'isbn':isbn}));
  }
  static Future<Response> bookDataFromTitle(String token, String title) async {
    return sendRequest(() => get(Uri.parse(BASE_ROUTE + '/user/data'),
        headers: <String, String>{'authorization': token, 'title':title}));
  }
}