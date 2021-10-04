library html_parser;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class MyHtmlParser {
  static List<Widget> parseHtmlToListOfTextWidgets(var text) {
    var data = parse(text.toString()).body;
    List<Widget> richText = [];
    for (int i = 0; i < data!.nodes.length; i++) {
      if (data.nodes[i].toString().contains('<html h1>')) {
        richText.add(_titleWidget(data.nodes[i].text));
      } else if (data.nodes[i].toString().contains('<html h2>')) {
        richText.add(_subtitleWidget(data.nodes[i].text));
      } else if (data.nodes[i].toString().contains('<html p>')) {
        richText.add(_paragraphWidget(data.nodes[i], data.nodes[i].text));
      } else if (data.nodes[i].toString().contains('<html ol>')) {
        richText.add(_numberedListWidget(data.nodes[i].nodes));
      } else if (data.nodes[i].toString().contains('<html ul>')) {
        richText.add(_bulletListWidget(data.nodes[i].nodes));
      } else if (data.nodes[i].toString().contains('<html b>')) {
        richText.add(_boldWidget(data.nodes[i].text));
      }
    }
    return richText;
  }

  static Widget _titleWidget(String? title) {
    return Text(title!,
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold));
  }

  static Widget _subtitleWidget(String? subtitle) {
    return Text(subtitle!,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }

  static Widget _boldWidget(String? text) {
    return Text(text!, style: TextStyle(fontWeight: FontWeight.bold));
  }

  static Widget _paragraphWidget(var nodesList, String? text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: nodesList.nodes.isEmpty
          ? Text(text!)
          : RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                children: _textSpanList(nodesList.nodes),
              ),
            ),
    );
  }

  static Widget _bulletListWidget(var bulletPoints) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: bulletPoints.length,
        itemBuilder: (BuildContext context, int index) {
          return bulletPoints[index].nodes.isEmpty
              ? Text('• ' + bulletPoints[index].text)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('• '),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: _textSpanList(bulletPoints[index].nodes),
                        ),
                      ),
                    ),
                  ],
                );
        });
  }

  static Widget _numberedListWidget(var numberedPoints) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: numberedPoints.length,
        itemBuilder: (BuildContext context, int index) {
          return numberedPoints[index].nodes.isEmpty
              ? Text('• ' + numberedPoints[index])
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(index.toString() + '. '),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: _textSpanList(numberedPoints[index].nodes),
                        ),
                      ),
                    ),
                  ],
                );
        });
  }

  static _textSpanList(var pointsNodes) {
    List<TextSpan> list = [];
    for (int i = 0; i < pointsNodes.length; i++) {
      if (pointsNodes[i].toString().contains('<html b>')) {
        list.add(TextSpan(
            text: pointsNodes[i].text,
            style: TextStyle(fontWeight: FontWeight.bold)));
      } else {
        list.add(TextSpan(text: pointsNodes[i].text));
      }
    }
    return list;
  }
}
