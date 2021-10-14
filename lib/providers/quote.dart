import 'package:books_app/services/base/base_services.dart';
import 'package:flutter/material.dart';

class QuoteService extends ChangeNotifier {
  final String apiUrl =
      'https://api.quotable.io/random?tags=inspirational,famous-quotes';
  String content = 'Once we accept our limits, we go beyond them.';
  String author = '- Albert Einstein'; //default quote

  Future<void> getQuote() async {
    try {
      final BaseServices baseServices = BaseServices();
      final Map<String, dynamic>? response = await baseServices.getAPI(apiUrl);
      content = response!['content'].toString();
      author = response['author'].toString();
      print(content + ' ' + author);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
