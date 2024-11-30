import 'package:flutter/material.dart';

import '../main.dart';

class ServiceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              height: 200,
              width: w,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top:2 ),
              child: Text(
                'Find our service',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 290, top: 6),
              child: Text(
                'View all ',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40,left: 10),
              child: Container(
                height: 200,
                width: w,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [

                    Stack(children: [
                      Container(
                        width: 170,
                        height:200 ,
                      ),
                      Container(
                        height: 150,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            image: DecorationImage(
                                image:
                                AssetImage('assets/images/station.jpg'),fit: BoxFit.fitHeight)
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 150),
                        child: Text(
                          'Book Your Train >>',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 170),
                        child: Text(
                          'Lets go for a trip',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: 14,
                    ),
                    Stack(children: [
                      Container(
                        height: 150,
                        width: 170,
                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(9),
                            image: DecorationImage(
                                image: AssetImage('assets/images/bb.png'),fit: BoxFit.fitHeight)),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 150),
                        child: Text(
                          'Book Your Bus >>',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 170),
                        child: Text(
                          'Lets go for a trip',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: 14,
                    ),
                  ],
                ),
              ),
            ),
          ]),

        ],
      ),
    );
  }
}
