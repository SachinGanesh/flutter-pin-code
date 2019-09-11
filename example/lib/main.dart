import 'package:flutter/material.dart';
import 'package:flutter_pin_code/flutter_pin_code.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Bottom sheet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _newTaskModalBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _newTaskModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PinCodeView(
            correctPin: 555555,
            title: Text(
              'Please input PIN to continue',
              style: TextStyle(color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            subTitle: InkWell(
              onTap: () {},
              child: Text(
                'Forgot PIN?',
                style: TextStyle(color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),
            errorMsg: 'Wrong PIN',
            onSuccess: (pin) {
              Navigator.pop(context);
              _showSnackBar(pin);
            },
          );
        });
  }

  void _showSnackBar(String pinCode) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "PIN Code: $pinCode",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }
}
