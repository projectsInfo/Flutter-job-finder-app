import 'package:flutter/material.dart';
import 'package:job/api/model.dart';
import 'package:job/constants.dart';
import 'package:job/models/company.dart';
import 'package:readmore/readmore.dart';

class CompanyCard extends StatelessWidget {
  final Posts? company;
  CompanyCard({this.company});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.0,
      margin: EdgeInsets.only(right: 15.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: kBlack,
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
                style: kTitleStyle.copyWith(color: Colors.white),
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
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'المزيد',
                  trimExpandedText: 'القليل',
                  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.orange),
                  lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.orange),
                ),
              ), ),
          // Text(
          //   company!.job_description,
          //   style: kTitleStyle.copyWith(
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          SizedBox(height: 15.0),
          // RichText(
          //   text: TextSpan(
          //     children: [
          //       TextSpan(
          //         text: company!.id.toString(),
          //         style: kSubtitleStyle.copyWith(
          //           color: Colors.white,
          //         ),
          //       ),
          //       TextSpan(
          //         text: "  •  ",
          //         style: kSubtitleStyle.copyWith(
          //           color: Colors.white,
          //         ),
          //       ),
          //       TextSpan(
          //         text: company!.company_id.toString(),
          //         style: kSubtitleStyle.copyWith(
          //           color: Colors.white,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: 15.0),
          // Expanded(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: company!.tag!
          //         .map(
          //           (e) => Container(
          //             alignment: Alignment.center,
          //             margin: EdgeInsets.only(right: 10.0),
          //             padding:
          //                 EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12.0),
          //               color: kBlackAccent,
          //             ),
          //             child: Text(
          //               e,
          //               style: kSubtitleStyle.copyWith(
          //                 color: Colors.white,
          //                 fontSize: 12.0,
          //               ),
          //             ),
          //           ),
          //         )
          //         .toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
