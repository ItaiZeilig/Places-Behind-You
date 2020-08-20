import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebehindyou/models/element.dart';
import 'package:placebehindyou/screens/single_element_screen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ElementCardInfo extends StatelessWidget {
  final SingleElement _element;
  Completer<GoogleMapController> _controller;

  ElementCardInfo(this._element, this._controller);

  Future<void> _goToPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(_element.location.lat, _element.location.lng),
        zoom: 15,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    print(_element.elementAttributes.rate);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _element.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SmoothStarRating(
                  allowHalfRating: false,
                  starCount: _element.elementAttributes.rate,
                  rating: _element.elementAttributes.rate.toDouble(),
                  size: 20.0,
                  isReadOnly: true,
                  color: Colors.yellow,
                  borderColor: Colors.white,
                  spacing: 0.0)
            ],
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleElementScreen(element: _element),
                ),
              );
            },
          ),
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.navigation),
            onPressed: () {
              _goToPosition();
            },
          ),
        ],
      ),
    );
  }
}
