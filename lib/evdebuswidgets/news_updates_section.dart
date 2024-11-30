// import 'package:flutter/material.dart';
//
// class NewsUpdatesSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Let’s get news updates', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//           SizedBox(height: 8),
//           NewsCard(
//             headline: 'Kamala Harris campaign team’s epic trolling of Donald Trump stuns netizens',
//             imagePath: 'assets/images/bus.png', // Replace with actual image path
//           ),
//           NewsCard(
//             headline: 'Another news headline',
//             imagePath: 'assets/images/bus.png', // Replace with actual image path
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../main.dart';

class NewsUpdatesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15,right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 10),
            child: Text('Let’s get news updates', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              height: 90,
              width: w,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [

                  Stack(children: [
                    Container(
                      width: 290,
                      height:90 ,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color: Colors.blueGrey.shade400),
                    ),
                    Container(
                      width: 230,
                      padding: EdgeInsets.only( top: 14,left: 10),
                      child: Text(
                        'Kamala Harris campaign team’s epic trolling of Donald Trump stuns netizens',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 125, top: 55),
                      child: Text(
                        'Read more',
                        style: TextStyle(color: Colors.black, fontSize: 13,decoration: TextDecoration.underline,),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 218, top: 16),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage('assets/images/news.jpg'),
                      ),
                    )
                  ]),  SizedBox(width: 5,), Stack(children: [
                    Container(
                      width: 290,
                      height:90 ,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color: Colors.blueGrey.shade400),
                    ),
                    Container(
                      width: 230,
                      padding: EdgeInsets.only( top: 14,left: 10),
                      child: Text(
                        'Kamala Harris campaign team’s epic trolling of Donald Trump stuns netizens',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 125, top: 55),
                      child: Text(
                        'Read more',
                        style: TextStyle(color: Colors.black, fontSize: 13,decoration: TextDecoration.underline,),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 218, top: 16),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage('assets/images/news.jpg'),
                      ),
                    )
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

