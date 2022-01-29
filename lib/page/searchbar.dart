import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:job/api/model.dart';
import 'package:job/views/home.dart';
import 'package:job/views/job_detail.dart';

//import 'package:search/model.dart';
//void main() {
//  runApp(MaterialApp(
//    home: SearchList(),
//    debugShowCheckedModeBanner: false,
//  ));
//}

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<Posts> _list = [];
  List<Posts> _search = [];
  var loading = false;

  final url = Uri.parse(
    //'https://gist.githubusercontent.com/JohannesMilke/d53fbbe9a1b7e7ca2645db13b995dc6f/raw/eace0e20f86cdde3352b2d92f699b6e9dedd8c70/books.json');
      'https://career.khksa.com/api/getjobs');

  // Drop Down List
  var _selectedLocation ; // Option 2

  Future<Null> fetchData() async {
    // final prefs = await SharedPreferences.getInstance();
    // final key = 'token';
    // final value = prefs.get(key) ?? 0;

    setState(() {
      loading = true;
    });

    _list.clear();

    final response =
//    await http.get("https://jsonplaceholder.typicode.com/posts");
        await http.get(url);

    if (response.statusCode == 200) {
      //final data = jsonDecode(response.body);

      Map map = json.decode(response.body);
      final List data = map["jobs"];
//      print('Data Cool Now :$data');
      setState(() {
        for (Map i in data) {
          _list.add(Posts.formJson(i));
          loading = false;
        }
      });
    } else {
      print('Data Null');
    }
  }

  TextEditingController controller = new TextEditingController();

//  DropdownButton dropController = new  DropdownButton(items: null, onChanged: (value) {  },);
//  DropdownMenuItem derood = new DropdownMenuItem(child: null);



//  DatabaseHelper databaseHelper = DatabaseHelper();
//  List<Posts> categoriesList ;
//  Posts _category;

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.title.toLowerCase().contains(text) || f.title.toUpperCase().contains(text) || f.id.toString().contains(text))
        _search.add(f);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black38,
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>  new Home()));
              },
            ),
          ],
          title: Text('ابحث عن وظيفتك'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.black38,
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: TextField(
                      controller: controller,
                      onChanged: onSearch,
                      decoration: InputDecoration(
                          hintText: "ابحث عن وظيفتك", border: InputBorder.none),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        controller.clear();
                        onSearch('');
                      },
                      icon: Icon(Icons.cancel),
                    ),
                  ),
                ),
              ),
              Center(
                  child: DropdownButton(
                    hint: Text('من فضلك اختر و ظيفتك'), // Not necessary for Option 1
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                        onSearch(_selectedLocation.toLowerCase());
                      });
                    },
                    items: _list.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location.title),
                        value: location.title,
                      );
                    }).toList(),
                  )
              ),
              loading
                  ? Center(
                      child:  CircularProgressIndicator(color: Colors.black38,),
                    )
                  : Expanded(
                      child: _search.length != 0 || controller.text.isNotEmpty
                          ? ListView.builder(
                              itemCount: _search.length,
                              itemBuilder: (context, i) {
                                final b = _search[i];
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: ()=> Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) => new Home()
                                      ),
                                    ),
                                    child: new Card(
                                      child: new ListTile(
                                        title: new Text(b.title),
                                        leading: new CircleAvatar(
                                          maxRadius: 30,
                                          minRadius: 30,
                                          backgroundImage: NetworkImage(
                                            'https://s0.2mdn.net/5481501/160x600-GCC-TWND_Bluewaters-English.jpg',
                                          ),
                                        ),
                                        subtitle: new Text('تفاصيل : ${b.title}'),
                                        trailing: IconButton(
                                          icon: Icon(Icons.account_box_outlined, color: Colors.black38,),
                                          onPressed: (){},
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: _list.length,
                              itemBuilder: (context, i) {
                                final a = _list[i];
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => JobDetail(
                                            company: a,
                                          ),
                                        ),
                                      );
                                    },
                                    child: new Card(
                                      child: new ListTile(
                                        title: new Text(a.title),
                                        leading: new CircleAvatar(
                                          maxRadius: 30,
                                          minRadius: 30,
                                          backgroundImage: NetworkImage(
                                            'https://s0.2mdn.net/5481501/160x600-GCC-TWND_Bluewaters-English.jpg',
                                          ),
                                        ),
                                        subtitle: new Text('تفاصيل : ${a.title}'),
                                        trailing: IconButton(
                                          icon: Icon(Icons.account_box_outlined , color: Colors.black38,),
                                          onPressed: (){},
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

