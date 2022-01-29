import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:job/model/book.dart';

class BooksApi {
  static Future<List<Book>> getBooks(String query) async {
    final url = Uri.parse(
        //'https://gist.githubusercontent.com/JohannesMilke/d53fbbe9a1b7e7ca2645db13b995dc6f/raw/eace0e20f86cdde3352b2d92f699b6e9dedd8c70/books.json');
    'https://career.khksa.com/api/getjobs');
    final response = await http.get(url);
    print('responseeeeeeeeeeeeeeeeeeeee1111111'+response.body);
    if (response.statusCode == 200) {
      final List books = json.decode(response.body);

      print('responseeeeeeeeeeeeeeeeeeeee22222'+response.body.toString());

      return books.map((json) => Book.fromJson(json)).where((book) {
        final titleLower = book.title.toLowerCase();
        final authorLower = book.author.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}