import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job/api/databasehelper.dart';
import 'package:job/api/model.dart';
import 'package:job/constants.dart';
import 'package:job/models/company.dart';
import 'package:job/page/searchbar.dart';
import 'package:job/views/job_detail.dart';
import 'package:job/views/search_screen.dart';
import 'package:job/widgets/company_card.dart';
import 'package:job/widgets/company_card2.dart';
import 'package:job/widgets/recent_job_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:readmore/readmore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Posts> _list = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }


  final url = Uri.parse(
    //'https://gist.githubusercontent.com/JohannesMilke/d53fbbe9a1b7e7ca2645db13b995dc6f/raw/eace0e20f86cdde3352b2d92f699b6e9dedd8c70/books.json');
      'https://career.khksa.com/api/getjobs');


  Future<Null> fetchData() async {
    // final prefs = await SharedPreferences.getInstance();
    // final key = 'token';
    // final value = prefs.get(key) ?? 0;

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
        }
      });
    } else {
      print('Data Null');
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSilver,
      appBar: AppBar(
        title: Text('تطبيق وظائف',style: TextStyle(color: Colors.black,fontSize: 30),),
        centerTitle: true,
        backgroundColor: kSilver,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
            top: 12.0,
            bottom: 12.0,
            right: 12.0,
          ),
          // child: SvgPicture.asset(
          //   "assets/drawer.svg",
          //   color: kBlack,
          // ),
        ),
        actions: <Widget>[
          // SvgPicture.asset(
          //   "assets/user.svg",
          //   width: 25.0,
          //   color: kBlack,
          // ),
          SizedBox(width: 18.0)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 25.0),
                Text(
                  "مرحبا بكم,\nأختر وظيفتك المفضلة",
                  style: kPageTitleStyle,
                ),
                SizedBox(height: 25.0),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  margin: EdgeInsets.only(right: 18.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: TextField(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchList(),
                                ),
                              );
                            },
                            cursorColor: kBlack,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.search,
                                size: 25.0,
                                color: kBlack,
                              ),
                              border: InputBorder.none,
                              hintText: "اختر و ظيفتك",
                              hintStyle: kSubtitleStyle.copyWith(
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchList(),
                            ),
                          );
                        },
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          margin: EdgeInsets.only(left: 12.0),
                          decoration: BoxDecoration(
                            color: kBlack,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Icon(
                            FontAwesomeIcons.slidersH,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 35.0),
                Text(
                  "الوظائف المتاحه",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  height: 190.0,
                  child: ListView.builder(
                    itemCount: _list.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var company = _list[index];
                      if(index == null){
                        return Center(
                          child:  CircularProgressIndicator(color: Colors.black38,),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobDetail(
                                company: company,
                              ),
                            ),
                          );
                        },
                        child: index == 0
                            ? CompanyCard(company: company)
                            : CompanyCard2(company: company),
                      );
                    },
                  ),
                ),
                SizedBox(height: 35.0),
                Text(
                  "اخر الوظائف",
                  style: kTitleStyle,
                ),

                ListView.builder(
                  itemCount: _list.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    var recent = _list[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetail(
                              company: recent,
                            ),
                          ),
                        );
                      },
                      child: RecentJobCard(company: recent),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// class Home extends StatelessWidget {
//   DatabaseHelper databaseHelper = new DatabaseHelper();
//   List<Posts> _list = [];
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }
