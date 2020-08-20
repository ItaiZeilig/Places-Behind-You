import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:placebehindyou/models/element.dart';

class SingleElementScreen extends StatelessWidget {
  static const routeName = '/singleElementScreen';

  SingleElement element;

  SingleElementScreen({Key key, @required this.element}) : super(key: key);

  List<File> _images;

  @override
  void didChangeDependencies() {
    _images = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Text("Element name : ${element.name}", style: TextStyle(fontSize: 16),),
              SizedBox(
                height: 50.0,
              ),
              Text("Element description : ${element.elementAttributes.description}",style: TextStyle(fontSize: 16),),
              SizedBox(
                height: 50.0,
              ),
              Text("Comments:", style: TextStyle(fontSize: 16),),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                    itemCount: element.elementAttributes.comments.length,
                    itemBuilder: (context, index) {
                      return Text(
                          element.elementAttributes.comments[index].comment,style: TextStyle(fontSize: 16),);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
