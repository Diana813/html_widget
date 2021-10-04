import 'package:flutter/material.dart';
import 'package:html_parser/html_parser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'html_parser demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'html_parser demo home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _htmlDoc;
  late List<Widget> _outputHtml;

  @override
  void initState() {
    super.initState();
    _htmlDoc = createHtmlDoc();
    _outputHtml = MyHtmlParser.parseHtmlToListOfTextWidgets(_htmlDoc);
  }

  String createHtmlDoc() {
    return '<h1>This package will help you display html document properly in your Flutter app.</h1>';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Html input: $_htmlDoc',
              ),
              Text(
                'Output: ',
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _outputHtml.length,
                itemBuilder: (contex, index) {
                  return _outputHtml.elementAt(index);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
