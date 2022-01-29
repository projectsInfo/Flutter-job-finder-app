import 'dart:convert';
//import 'package:filter_listview_example/api/testAPI.dart';
import 'package:http/http.dart' as http;


class DatabaseHelper{
  String serverUrl = "http://flutterapisup.achilles-store.com/api";
  var status;
  var token;

  final url = Uri.parse(
    //'https://gist.githubusercontent.com/JohannesMilke/d53fbbe9a1b7e7ca2645db13b995dc6f/raw/eace0e20f86cdde3352b2d92f699b6e9dedd8c70/books.json');
      'https://career.khksa.com/api/getjobs');

  //Show Product Function
  Future<void> getData() async{

    //String myUrl = "$serverUrl/products/";
    http.Response response = await http.get(url);

    var body = response.body;
     //TestAPI testAPI = TestAPI.fromjson(json.decode(body));

    //print('zxczxczxczxczxczcxzxczxczxczxczxc'+testAPI.data.toString());

  }


  // final url = Uri.parse(
  //   //'https://gist.githubusercontent.com/JohannesMilke/d53fbbe9a1b7e7ca2645db13b995dc6f/raw/eace0e20f86cdde3352b2d92f699b6e9dedd8c70/books.json');
  //     'https://career.khksa.com/api/getjobs');

  

  Future<List> callAPI() async{
    var response = await http.get(url);

    //var body = response.body;

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["jobs"];
    print('whast ${data[0]['id']}');
    //return data[0]['id'];
    return data;
    // TestAPI testAPI =TestAPI.fromjson(jsonDecode(body));
    // print('aaaaaaaaaaaaaaaaaaaaaaaa'+testAPI.data.toString());
  }


}