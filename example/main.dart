import 'package:flutter/material.dart';
import 'package:more_widgets/more_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'MyEasyDialogs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () => Dialogs.infoDialog(
                  context: context,
                  title: "Example",
                  message: "I'm an infoDialog example !"),
              child: const Text("Show infoDialog"),
            ),
            TextButton(
              onPressed: () => Dialogs.dialogWithOptions(
                  context: context,
                  title: "Example",
                  message: "I'm an infoDialog example !",
                  textLeftButton: "Yes",
                  onPressedLeftButton: () => print("yes")),
              child: const Text("Show dialogWithOptions"),
            ),
          ],
        ),
      ),
    );
  }
}
