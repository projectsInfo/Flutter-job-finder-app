import 'package:flutter/material.dart';
import 'package:job/api/model.dart';
import 'package:job/constants.dart';
import 'package:job/models/company.dart';
import 'package:readmore/readmore.dart';

class CompanyCard2 extends StatelessWidget {
  final Posts? company;
  CompanyCard2({this.company});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.0,
      margin: EdgeInsets.only(right: 15.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: AssetImage('assets/download.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Spacer(),
              Text(
                company!.title,
                style: kTitleStyle,
              ),
            ],
          ),
          SizedBox(height: 15.0),

          Expanded(
            child:SingleChildScrollView(
              child: ReadMoreText(
                //'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                company!.job_description,
                trimLines: 2,
                style: kTitleStyle,
                colorClickableText: Colors.black,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'المزيد',
                trimExpandedText: 'القليل',
                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.orange),
                lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.orange),
              ),
            ), ),

          // Text(
          //   company!.job_description,
          //   style: kTitleStyle,
          // ),
          SizedBox(height: 15.0),
          // RichText(
          //   text: TextSpan(
          //     children: [
          //       TextSpan(
          //         text: company!.id.toString(),
          //         style: kSubtitleStyle,
          //       ),
          //       TextSpan(
          //         text: "  •  ",
          //         style: kSubtitleStyle,
          //       ),
          //       TextSpan(
          //         text: company!.company_id.toString(),
          //         style: kSubtitleStyle,
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: 15.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: company!.tag!
          //       .map(
          //         (e) => Container(
          //           alignment: Alignment.center,
          //           margin: EdgeInsets.only(right: 10.0),
          //           padding:
          //               EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12.0),
          //             color: Colors.white,
          //             border: Border.all(
          //               color: kBlack,
          //               width: 0.5,
          //             ),
          //           ),
          //           child: Text(
          //             e,
          //             style: kSubtitleStyle.copyWith(
          //               fontSize: 12.0,
          //             ),
          //           ),
          //         ),
          //       )
          //       .toList(),
          // ),
        ],
      ),
    );
  }
}
