import "dart:async";

import "package:flutter/material.dart";
import "package:jz_base_page/jz_base_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "A demo App for jz_base_page"),
    );
  }
}

class MyHomePage extends JZBasePage {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  JZBasePageState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends JZBasePageState<MyHomePage> {
  int _countDownNumber = 5;

  @override
  Widget contentBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            width: MediaQuery.of(context).size.width,
            child: isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Loading ends in:",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        "$_countDownNumber",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  )
                : Container(),
          ),
          Center(
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              overflowButtonSpacing: 20,
              buttonPadding: const EdgeInsets.all(50),
              children: [
                ElevatedButton(
                  onPressed: _showLoading,
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.headline4,
                    ),
                    minimumSize: MaterialStateProperty.all(const Size(300, 60)),
                  ),
                  child: const Text(
                    "Show Loading",
                  ),
                ),
                ElevatedButton(
                  onPressed: _showToast,
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.headline4,
                    ),
                    minimumSize: MaterialStateProperty.all(const Size(300, 60)),
                  ),
                  child: const Text(
                    "Show Toast",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLoading() async {
    _countDownNumber = 5;
    startLoading(message: "Loading...");
    while (_countDownNumber > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _countDownNumber--;
      });
    }
    stopLoading();
  }

  void _showToast() {
    showToast(
      message: "This toast will disappear in 5 seconds. "
          "You can also manually hide it by clicking the dimmed background.",
      dismissAfterDelay: const Duration(seconds: 5),
    );
  }
}
