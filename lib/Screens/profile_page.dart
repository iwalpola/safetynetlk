import 'package:flutter/material.dart';
import 'package:safetynetlk/models/user_model.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel = context.read<UserModel>();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Data from logged in user:"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Name: " + userModel.name.toString()),
            Text("Email: " + userModel.email.toString()),
            Text("Facebook ID: " + userModel.fbID.toString()),
            Text("Picture url: " + userModel.photoProfile.toString())
          ],
        )
            //child: _displayUserData(user.profileData),
            ),
      ),
    );
  }

  /** _displayUserData(profileData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
               image: NetworkImage(
                profileData['picture']['data']['url'],
              ),
              
            ),
          ),
        ),
        SizedBox(height: 28.0),
        Text(
          "Logged in as: ${profileData['name']}",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ],
    );
}*/

}
