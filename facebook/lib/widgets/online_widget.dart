import 'package:flutter/material.dart';

class OnlineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 15.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                border: Border.all(width: 1.0, color: Colors.blue)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.video_call, size: 30.0, color: Colors.purple),
                SizedBox(width: 5.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Create', style: TextStyle(color: Colors.blue)),
                    Text('Room', style: TextStyle(color: Colors.blue)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(width: 15.0),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: AssetImage('assets/images/story8.jpg'),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: AssetImage('assets/images/story7.jpg'),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: AssetImage('assets/images/story6.jpg'),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: AssetImage('assets/images/story5.jpg'),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: AssetImage('assets/images/story4.jpg'),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: AssetImage('assets/images/story3.jpg'),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: AssetImage('assets/images/story2.jpg'),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: AssetImage('assets/images/story1.jpg'),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: AssetImage('assets/images/story8.jpg'),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundImage: AssetImage('assets/images/story7.jpg'),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.0),
        ],
      ),
    );
  }
}
