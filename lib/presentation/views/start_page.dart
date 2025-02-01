import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaler;

    return Flexible(
      child: Scaffold(
        body: SafeArea(
            child: Container(
                child: Column(
          children: [
            Image.asset('assets/images/Hello.svg'),
            Text(textScaleFactor.toString()),
            Text("Start"),
            Row(
              children: [
                TextButton(
                  onPressed: null,
                  child: Text("Login"),
                ),
                TextButton(
                  onPressed: null,
                  child: Text("Sign up"),
                ),
              ],
            )
          ],
        ))),
      ),
    );
  }
}
