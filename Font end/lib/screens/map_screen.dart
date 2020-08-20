import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebehindyou/screens/single_element_screen.dart';
import 'package:placebehindyou/services/element_service.dart';
import 'package:placebehindyou/services/user_service.dart';
import 'package:placebehindyou/widgets/elementCardInfo.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Get current location
  Location location = new Location();
  static LocationData _locationData;
  Set<Marker> _markers = {};
  var _isLoading = true;
  UserService _userService;
  ElementService _elementService;
  var _initFirst = true;
  @override
  void didChangeDependencies() {
    if (_initFirst) {
      _userService = Provider.of<UserService>(context);
      _elementService = Provider.of<ElementService>(context);
      getLocation().whenComplete(() => {
            _elementService
                .fetchAllElements(_userService.getUser.userId.email)
                .whenComplete(() => {
                      setState(() {
                        convertElementsToMarkers();
                        _isLoading = false;
                        _initFirst = false;
                      })
                    })
          });
    }
    super.didChangeDependencies();
  }

  void convertElementsToMarkers() {
    _elementService.getAllElements.forEach((element) {
      Marker marker = Marker(
        infoWindow: InfoWindow(
            title: element.name,
            onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SingleElementScreen(element: element),
                    ),
                  )
                }),
        markerId: MarkerId(element.elementId.id),
        position: LatLng(element.location.lat, element.location.lng),
      );
      _markers.add(marker);
    });
    print(_markers);
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
          : Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2,
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
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height /2,
                  child: ListView.builder(
                      itemCount: _elementService.getAllElements.length,
                      itemBuilder: (context, index) {
                        return ElementCardInfo(_elementService.getAllElements[index], _controller);
                      }),
                )
              ],
            ),
    );
  }
}
