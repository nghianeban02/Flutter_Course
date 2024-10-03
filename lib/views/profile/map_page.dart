
import 'dart:convert';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery/core/constants/app_defaults.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
// import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TextEditingController _addressController = TextEditingController();
  late String lat;
  late String long;
  String locationMessage = 'Current location';
  late GoogleMapController mapController;
  final LatLng initialLocation =
      LatLng(40.7128, -74.0060); // Initial location for the map
  Set<Marker> markers = {}; // Set to hold markers

  Future<void> getAddress() async {
    setState(() {
      _addressController.text = locationMessage;
    });
    _liveLocation();
  }

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Chức năng vị trí trên điện thoại chưa được bật');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Chức năng vị trí trên điện thoại chưa được bật');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Chức năng vị trí bị hủy kích hoạt,không thể lấy dữ liệu vị trí');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      setState(() {
        locationMessage = 'KD: $lat,VD: $long';
      });
    });
  }

  GoogleMapController? _mapController;
  // final Location _location = Location();
  // Future<void> _getAddressFromCoordinates(
  //     double latitude, double longitude) async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(latitude, longitude);
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       _address = "${place.street}, ${place.locality}, ${place.country}";
  //     });
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  LatLng _currentLocation = LatLng(10.77615745855286, 106.66759669033004);

  Set<Marker> _markers = {};

  // Function to convert address to LatLng coordinates
  Future<LatLng?> _getLatLngFromAddress(String address) async {
    final apiKey =
        'AIzaSyCLuHzl8WwEzIHGiTW_MK9_8FHmyO48Vgg'; // Replace with your actual API key
    final encodedAddress = Uri.encodeComponent(address);
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        final location = results[0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        return LatLng(lat, lng);
      }
    }
    return null;
  }

  // Function to add marker to the map
  Future<void> _addMarkerFromAddress(String address) async {
    final latLng = await _getLatLngFromAddress(address);
    if (latLng != null) {
      setState(() {
        markers.clear();
        markers.add(Marker(markerId: MarkerId('target'), position: latLng));
      });
    } else {
      // Handle error case
    }
  }

  Future<void> _addMarkerFromCurrentLocation() async {
    final latLng = LatLng(double.parse(lat), double.parse(long));
    setState(() {
      markers.clear();
      markers
          .add(Marker(markerId: MarkerId(locationMessage), position: latLng));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn từ bản đồ'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Nhập địa chỉ của bạn',
                  ),
                  onFieldSubmitted: (value) {
                    _addMarkerFromAddress(value);
                  },
                ),
                // Text(locationMessage),
                Positioned(
                  top: 0,
                  right: 0,
                  child: SizedBox(
                    width: 56,
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () {
                        _getCurrentLocation().then(
                          (value) {
                            lat = '${value.latitude}';
                            long = '${value.longitude}';
                          },
                        );
                        setState(() {
                          _addressController.text = " $lat,$long";
                          print(locationMessage);
                          _addMarkerFromCurrentLocation();
                        });
                      },
                      child: Icon(Icons.my_location),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDefaults.padding),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initialLocation,
                zoom: 17,
              ),
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              markers: markers,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text(
                'Lưu',
                style: TextStyle(fontSize: 19),
              ),
              // backgroundColor: Colors.green,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
