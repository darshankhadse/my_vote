import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myvote/constants.dart';
import 'package:myvote/screens/home_screen.dart';
import 'package:myvote/screens/launch_screen.dart';
import 'package:myvote/screens/result_screen.dart';
import 'package:myvote/state/vote.dart';
import 'package:myvote/state/authentication.dart';
import 'package:myvote/utilities.dart';

void main() {
  runApp(VoteApp());
}

class VoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => VoteState()),
          ChangeNotifierProvider(create: (_) => AuthenticationState()),
        ],
        child:
        Consumer<AuthenticationState>(builder: (context, authState, child) {
          return MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => Scaffold(
                body: LaunchScreen(),
              ),
              '/home': (context) => Scaffold(
                appBar: AppBar(
                  title: Text(kAppName),
                  actions: <Widget>[
                    getActions(context, authState),
                  ],
                ),
                body: HomeScreeen(),
              ),
              '/result': (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Result'),
                  leading: IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  actions: <Widget>[
                    getActions(context, authState),
                  ],
                ),
                body: ResultScreen(),
              )
            },
          );
        }));
  }

  PopupMenuButton getActions(
      BuildContext context, AuthenticationState authState) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Logout'),
        )
      ],
      onSelected: (value) {
        if (value == 1) {
          // logout
          authState.logout();
          gotoLoginScreen(context, authState);
        }
      },
    );
  }
}