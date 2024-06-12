import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';

class MapPage extends StatefulWidget {
  final List<Map<String, dynamic>> attractions;

  MapPage({Key? key, required this.attractions}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(29.033333, 29.933334);
  late Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    for (var attraction in widget.attractions) {
      final markerColor = Color(attraction['color']);
      final markerIcon = await _getMarkerIcon(markerColor);

      final marker = Marker(
        markerId: MarkerId(attraction['Attraction_Name']),
        position: LatLng(
          double.parse(attraction['Latitude'].toString()),
          double.parse(attraction['Longitude'].toString()),
        ),
        infoWindow: InfoWindow(
          title: attraction['Attraction_Name'],
        ),
        icon: markerIcon,
      );

      print(
          'Adding marker: ${attraction['Attraction_Name']} at ${attraction['Latitude']}, ${attraction['Longitude']} with color ${markerColor.value}');

      _markers.add(marker);
    }

    setState(() {}); // Update the state to reflect new markers
  }

  Future<BitmapDescriptor> _getMarkerIcon(Color color) async {
    String assetPath;
    if (color.value == Colors.blue.value) {
      assetPath = 'assets/marker/blue.png';
    } else if (color.value == Colors.green.value) {
      assetPath = 'assets/marker/green.png';
    } else if (color.value == Colors.orange.value) {
      assetPath = 'assets/marker/orange.png';
    } else if (color.value == Colors.pink.value) {
      assetPath = 'assets/marker/pink.png';
    } else if (color.value == Colors.red.value) {
      assetPath = 'assets/marker/red.png';
    } else {
      assetPath = 'assets/marker/red.png'; // Default color
    }

    final ByteData byteData = await rootBundle.load(assetPath);
    final Uint8List markerBytes = byteData.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(markerBytes);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {}); // Update the state to reflect new markers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          'Attractions Map',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 6,
        ),
        markers: _markers,
      ),
    );
  }
}
