import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Demo',
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class MyMapPage extends StatefulWidget {
  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  Set<Marker> _markers = {};

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(38.0356, -78.5034),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId('uva-lawn'),
        position: LatLng(38.0362, -78.5055),
        infoWindow: InfoWindow(
          title: 'UVA Lawn',
          snippet:
              'Historic grassy field with academic buildings & landmarks, plus a statue of Thomas Jefferson.',
        ),
        onTap: () => _showLocationInfo(context, MarkerId('uva-lawn')),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('rotunda'),
        position: LatLng(38.0368, -78.5031),
        infoWindow: InfoWindow(
          title: 'The Rotunda',
          snippet:
              'Iconic building designed by Thomas Jefferson & serving as the centerpiece of the university.',
        ),
        onTap: () => _showLocationInfo(context, MarkerId('rotunda')),
      ),
    );
  }

  void _showLocationInfo(BuildContext context, MarkerId markerId) {
    final Marker marker = _markers.where((m) => m.markerId == markerId).first;
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  marker.infoWindow.title!,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  marker.infoWindow.snippet!,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UVA Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
        markers: _markers,
      ),
    );
  }
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _uvaPosition = CameraPosition(
    target: LatLng(38.0336, -78.507980),
    zoom: 15,
  );
  Set<Marker> _markers = Set.from([
    Marker(
      markerId: MarkerId('rotunda'),
      position: LatLng(38.0365, -78.5034),
      infoWindow: InfoWindow(
        title: 'The Rotunda',
        snippet: 'Academic landmark and symbol of the University of Virginia',
      ),
    ),
    Marker(
      markerId: MarkerId('alderman'),
      position: LatLng(38.0369, -78.5087),
      infoWindow: InfoWindow(
        title: 'Alderman Library',
        snippet: 'Main library on UVA grounds, named after Edwin Alderman',
      ),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Demo'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _uvaPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
      ),
    );
  }
}
