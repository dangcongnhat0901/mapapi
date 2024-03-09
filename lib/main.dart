import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Map',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(15.975149, 108.254544),
    zoom: 11.5,
  );
  late GoogleMapController _googleMapController;
  late Marker _origin = Marker(
    markerId: const MarkerId('origin'),
    position: LatLng(0, 0),
  );
  late Marker _destination = Marker(
    markerId: const MarkerId('destination'),
    position: LatLng(0, 0),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title:  Text('Google Maps'),
        actions: [
          TextButton(
            onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _origin.position,
            zoom: 14.5,
            tilt: 50.0
            
            )
            
          ),
        ),
         style: TextButton.styleFrom(
          
         )
         ,
        child:  Text('ORIGIN'),
        )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) {
          setState(() {
            _googleMapController = controller;
          });
        },
        markers: {
          if (_origin != null) _origin,
          if (_destination != null) _destination
          
        },
        onLongPress: _addMaker,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(15.975149, 108.254544), // vị trí mới
            15.0, // mức độ phóng to mới
          ),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

void _addMaker(LatLng pos) {
  setState(() {
    if (_origin.position == LatLng(0, 0)) {
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
    } else if (_destination.position == LatLng(0, 0)) {
      _destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );
    } else {
      // Nếu cả _origin và _destination đều đã được khởi tạo
      // Ta cập nhật lại _origin
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
      // và reset _destination về LatLng(0, 0)
      _destination = Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(0, 0),
      );
    }
  });
}


}
