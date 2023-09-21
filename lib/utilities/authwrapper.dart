import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/view/home/homepage.dart';

import '../provider/authprovider.dart';
import '../view/auth/loginpage.dart';

// import '../provider/auth_provider.dart';

class AuthWrapper extends StatefulWidget {
  AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: Provider.of<AuthProvider>(context, listen: false).loadconfig(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return Container();
        } else if (snapshot.data == 'login') {
          return LoginPage();
        } else if (snapshot.data == 'home') {
          return HomePage();
        }
      return Container(); // Main Screen
      },
    );
  }
}
