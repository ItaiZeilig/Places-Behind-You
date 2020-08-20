import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebehindyou/models/newElement.dart';
import 'package:placebehindyou/services/element_service.dart';
import 'package:placebehindyou/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

class CreateElementScreen extends StatefulWidget {
  static const routeName = '/createElementScreen';

  @override
  _CreateElementScreenState createState() => _CreateElementScreenState();
}

class _CreateElementScreenState extends State<CreateElementScreen> {
  // Get current location
  Location location = new Location();
  static LocationData _locationData;
  var _isLoading = true;
  UserService _userService;
  ElementService _elementService;
  var _initFirst = true;
  final _formKey = GlobalKey<FormState>();
  String img64;
  File _image;

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
        context: context,
        source: source,
        cameraIcon: Icon(
          Icons.camera_alt,
          color: Colors.red,
        ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: Text(
          "From Camera",
          style: TextStyle(color: Colors.red),
        ),
        galleryText: Text(
          "From Gallery",
          style: TextStyle(color: Colors.blue),
        ));
    setState(() {
      _image = image;
      img64 = base64Encode(image.readAsBytesSync());
    });
  }

  Map<String, dynamic> _authData = {
    'type': '',
    'name': '',
    'description': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      NewElement element = new NewElement(
        active: true,
        type: _authData['type'],
        name: _authData['name'],
        location: NewLocation(
            lat: _locationData.latitude, lng: _locationData.longitude),
        elementAttributes: NewElementAttributes(
            description: _authData['description'],
            comments: [],
            pictures: [img64],
            rate: 1),
      );
      _elementService.createNewElement(
          _userService.getUser.userId.email, element);
    } catch (error) {
      _showErrorDialog(error.message);
      _isLoading = false;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_initFirst) {
      _userService = Provider.of<UserService>(context);
      _elementService = Provider.of<ElementService>(context);
      getLocation().whenComplete(() => {
            setState(() {
              _isLoading = false;
              _initFirst = false;
            })
          });
    }
    super.didChangeDependencies();
  }

  Future<void> getLocation() async {
    try {
      _locationData = await location.getLocation();
      print(_locationData);
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: GoogleMap(
                      onTap: (LatLng location) {
                        setState(() {});
                      },
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            _locationData.latitude, _locationData.longitude),
                        zoom: 13,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _image != null
                            ? Image.file(
                                _image,
                                width: 200,
                                height: 150,
                              )
                            : Container(),
                        IconButton(
                          icon: Icon(Icons.camera_enhance),
                          color: Theme.of(context).primaryColor,
                          iconSize: 40,
                          tooltip: 'Upload a photo',
                          onPressed: () => getImage(ImgSource.Both),
                        ),
                        TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: 'Element name',
                          ),
                          keyboardType: TextInputType.text,
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid Element name!';
                            }
                          },
                          onSaved: (value) {
                            _authData['name'] = value;
                          },
                        ),
                        TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: 'Element type',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid Element type!';
                            }
                          },
                          onSaved: (value) {
                            _authData['type'] = value;
                          },
                        ),
                        TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: 'Element description',
                          ),
                          keyboardType: TextInputType.text,
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid Element description!';
                            }
                          },
                          onSaved: (value) {
                            _authData['description'] = value;
                          },
                        ),
                        if (_isLoading)
                          CircularProgressIndicator()
                        else
                          ButtonTheme(
                            minWidth: 300.0,
                            child: RaisedButton(
                              color: Color(0xFFc1b7f3),
                              onPressed: _submit,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
