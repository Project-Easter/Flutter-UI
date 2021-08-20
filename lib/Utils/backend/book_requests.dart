import 'package:books_app/constants/api.dart';
import 'package:books_app/providers/book.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:http/http.dart';

class BookRequest {
  static Future<Response> bookDataFromISBN(String token, String isbn) async {
    return sendRequest(() => get(
            Uri.parse(BASE_ROUTE + '/book/data/isbn/' + isbn),
            headers: <String, String>{
              'authorization': token,
            }));
  }

  static Future<Response> bookDataFromTitle(String token, String title) async {
    return sendRequest(() => get(
            Uri.parse(BASE_ROUTE + '​/book​/data​/title/​' + title),
            headers: <String, String>{
              'authorization': token,
            }));
  }

  static Future<Response> postBook(String token, Book book) async {
    return sendRequest(
        () => post(Uri.parse(BASE_ROUTE + '/book'), headers: <String, String>{
              'authorization': token,
            }, body: <String, String>{
              'isbn': book.isbn,
              'title': book.title,
              'description': book.description,
              'author': book.author,
              'pages': book.pages,
              'genre': book.category,
              'language': 'ENGLISH'
            }));
  }
}
