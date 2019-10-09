import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp Helper',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Enter number'),
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
  int _counter = 0;

  TextEditingController _controller = TextEditingController();
  TextEditingController _contryController = TextEditingController();

  BuildContext _context;

  void _pressed() async {
    String number = _controller.text;
    if (number.length < 10) {
      Toast.show("Phone is less than 10", _context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return;
    }

    String url =
        'https://api.whatsapp.com/send?phone=${_contryController.text}${_controller.text}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show("Coun't open whatsapp", _context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _controller.text = "";
    _contryController.text = "+91";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "App Opens the entered number directly in whatsapp, if it exits",
                textScaleFactor: 1.5,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 2,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _contryController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 8,
                    child: TextField(
                      maxLength: 10,
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Phone number",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: RaisedButton(
                  onPressed: _pressed,
                  child: Text("Open in whatsapp"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
