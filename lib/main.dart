import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness:Brightness.dark,
        primarySwatch: Colors.deepPurple,
        primaryColor: const Color(0xFF212121),
        accentColor: const Color(0xFF673AB7),
        canvasColor: const Color(0xFF212121),
      ),
      home: MyHomePage(title: 'Random Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
          child: new Text(
            widget.title,
            textAlign: TextAlign.center,
          )
        )
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[

          new Text(
            "Enter a list seperated by comma ,.",
            textAlign: TextAlign.center,
          ),

          new Divider(
            color: Colors.white,
            indent: 60.0,
            endIndent: 60.0,
          ),

          new TextField(
              controller: _inputController,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Enter text here...',
              ),
              cursorColor: const Color(0xFF673AB7),
              style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontFamily: "Roboto"
              ),
          ),

          Spacer(),

          // Middle Divider
          new Divider(
            color: Colors.white,
            indent: 15.0,
            endIndent: 15.0,
          ),

          Flexible(
            flex: 3,
            child: Text(
              "Winner:",
              style: new TextStyle(
                fontSize: 28,
                letterSpacing: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Text(
            "$winner",
            style: new TextStyle(
              fontSize: 32,
              letterSpacing: 3,
            ),
            textAlign: TextAlign.center,
          ),

          new Divider(
            color: Colors.white,
            indent: 120.0,
            endIndent: 120.0,
          ),

          Spacer(),

          SizedBox(
            width: 175, height: 40,
            child:
            RaisedButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: const Color(0xFF673AB7)),
              ),
              onPressed: () => pick(),
              color: const Color(0xFF673AB7),
              highlightColor: const Color(0xFF212121),
              textColor: Colors.white,
              child: Text(
                "pick".toUpperCase(),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),

        ],
      ),

      // Bottom
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF212121),
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                icon: const Icon(Icons.delete),
                onPressed: clear,
                iconSize: 24.0,
                color: const Color(0xFFffffff),
                highlightColor: Colors.red,
              ),

              Spacer(),

              new PopupMenuButton(
                onSelected: popupMenuSelected,
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<String>>[
                  const PopupMenuItem( child: const Text("Settings"), value: "Settings",),
                  const PopupMenuItem( child: const Text("Save (soon)"), value: "Save",),
                  const PopupMenuItem( child: const Text("Load (soon)"), value: "Load",),
                  const PopupMenuItem( child: const Text("Credits"), value: "Credits",),
                ],
              )

            ],
        ),
      ),

    );
  }

  var _inputController = TextEditingController();

  void clear()
  {
    _inputController.clear();
  }

  var list = [];
  int index;
  String input;
  String winner = "";

  resetValue()
  {
    list.clear();
    input = "";
  }

  void pick()
  {

    input = _inputController.text;
    index = 0;

    input.split(',').forEach((element) { list.add(element); });
    index = Random().nextInt(list.length);

    setState(() {
      winner = list[index].toString();
    });

    resetValue();

  }

  void popupMenuSelected(String valueSelected)
  {
    if (valueSelected == "Settings")
      _settings();
    else if (valueSelected == "Save")
      showComingSoonAlertDialog(context);
    else if (valueSelected == "Load")
      showComingSoonAlertDialog(context);
    else if (valueSelected == "Credits")
      showCreditsAlertDialog(context);
  }

  showErrorAlertDialog(BuildContext context, String inp, String out)
  {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Invailed Number"),
      content: Text(_inputController.text + " isn't a actual " + inp + " number and can't be converted to " + out + "."),
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

  showCreditsAlertDialog(BuildContext context)
  {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Credits".toUpperCase()),
      content: Text(
        "Developed by: Bluewolf787\n" +
            "Version: 1.8.7",
      ),
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

  showComingSoonAlertDialog(BuildContext context)
  {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Uops!"),
      content: Text(
          "Seams here is nothing to see right now. (coming soon)"
      ),
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

  void _settings()
  {

    /* TODO: show meme when switching theme with modal bottom sheet
     * dark = I see you're a men of culture aswell
     * light = something else
     */

    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text("Settings"),
            ),
            body: Center(
              child: Text("Coming soon!".toUpperCase()),
            ),
          );
        },
      ),
    );
  }

}
