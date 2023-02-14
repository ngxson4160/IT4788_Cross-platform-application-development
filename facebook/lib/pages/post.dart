import 'package:facebook/pages/home_page.dart';
import 'package:facebook/pages/upload_image.dart';
import 'package:flutter/material.dart';

import '../services/remote_service.dart';
import '../values/api_values.dart';
import '../values/app_colors.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      // title: appTitle,

      home: Scaffold(
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
// Create a global key that uniquely identifies the Form widget
// and allows validation of the form.
//
// Note: This is a GlobalKey<FormState>,
// not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController described = TextEditingController();
  bool _filedPhoneNumber = false;

  showAlertDialogPost(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thông báo!"),
      content: Text("Bạn đã đăng bài thành công."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          children: [
            // Icon(Icons.arrow_back),
            IconButton(
              icon: Icon(Icons.cancel_outlined),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
                ;
              },
            ),
            const SizedBox(
              width: 20,
            ),
            Center(
                child: Text('Tạo bài viết',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold))),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                addAPost(ApiValues.TOKEN.toString(), described.text.toString());
                showAlertDialogPost(context);
              },
              child: Text('Đăng',
                  style: TextStyle(
                      color: (!_filedPhoneNumber)
                          ? AppColors.lightBlue
                          : AppColors.white,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
        Divider(
          thickness: 1,
        ),
        const SizedBox(
          height: 5,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 31.0,
            backgroundImage: NetworkImage(ApiValues.AVATAR.toString()),
          ),
          title: Text(ApiValues.USERNAME.toString()),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style:
                        OutlinedButton.styleFrom(foregroundColor: Colors.grey),
                    onPressed: () {},
                    icon: Icon(Icons.group),
                    label: Row(
                      children: [
                        Text('Friends'),
                        Expanded(
                          child: Icon(
                            Icons.arrow_drop_down,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: OutlinedButton.icon(
                    style:
                        OutlinedButton.styleFrom(foregroundColor: Colors.grey),
                    // onPressed: () {},
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadImages()));
                    },
                    icon: Icon(Icons.add),
                    label: Row(
                      children: [
                        Text('Album'),
                        Expanded(
                          child: Icon(
                            Icons.arrow_drop_down,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: described,
          maxLines: 8,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'What\'s on your Mind?',
            hintStyle: TextStyle(fontSize: 20),
          ),
          onChanged: (value) {
            setState(() {
              if (value.isNotEmpty) {
                _filedPhoneNumber = true;
              }
              if (value.isEmpty) {
                _filedPhoneNumber = false;
              }
            });
          },
        ),
      ],
    );
  }
}
