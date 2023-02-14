import 'package:facebook/tabs/home_tab.dart';
import 'package:facebook/tabs/profile_tab.dart';
import 'package:facebook/tabs/notifications_tab.dart';
import 'package:facebook/tabs/menu_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../tabs/request_friend_tab.dart';
import '../tabs/search.dart';
import '../values/api_values.dart';

final _storage = new FlutterSecureStorage();
Future<String?> getUserName() async {
  return await _storage.read(key: "userName");
}

Future<String?> getToken() async {
  return await _storage.read(key: "token");
}

Future<String?> getId() async {
  return await _storage.read(key: "id");
}

Future<String?> getAvatar() async {
  return await _storage.read(key: "avatar");
}

void getData() async {
  ApiValues.USERNAME = await getUserName();
  ApiValues.TOKEN = await getToken();
  ApiValues.ID = await getId();
  ApiValues.AVATAR = await getAvatar();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    getData();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('facebook',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Search()));
                  },
                  child: Icon(Icons.search, color: Colors.black)),
              SizedBox(width: 15.0),
              Icon(FontAwesomeIcons.facebookMessenger, color: Colors.black)
            ]),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Colors.blueAccent,
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blueAccent,
          tabs: [
            Tab(icon: Icon(Icons.home, size: 30.0)),
            Tab(icon: Icon(Icons.people, size: 30.0)),
            Tab(icon: Icon(Icons.account_circle, size: 30.0)),
            Tab(icon: Icon(Icons.notifications, size: 30.0)),
            Tab(icon: Icon(Icons.menu, size: 30.0))
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        HomeTab(),
        FriendRequestPage(),
        ProfileTab(
            name: ApiValues.USERNAME,
            id: ApiValues.ID,
            // id: "63e127401ddfbc0040edfd74",
            avatar: ApiValues.AVATAR),
        NotificationsTab(),
        MenuTab()
      ]),
    );
  }
}
