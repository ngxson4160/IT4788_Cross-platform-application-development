import 'package:flutter/material.dart';

class StoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 15.0),
          Container(
            width: 120.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: AssetImage('assets/images/story1.jpg'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(width: 10.0),
          Container(
            width: 120.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/story2.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: 10.0),
          Container(
            width: 120.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/story3.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: 10.0),
          Container(
            width: 120.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/story4.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: 10.0),
          Container(
            width: 120.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/story5.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: 10.0),
          Container(
            width: 120.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/story6.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: 10.0),
          Container(
            width: 120.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/story7.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: 10.0),
          Container(
            width: 120.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/story8.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: 15.0),
        ],
      ),
    );
  }
}
