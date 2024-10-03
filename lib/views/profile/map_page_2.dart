import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery/core/constants/app_defaults.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocery/core/models/tools_viewmodel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
// import 'package:location/location.dart';

class MapPage2 extends StatefulWidget {
  const MapPage2({Key? key}) : super(key: key);

  @override
  State<MapPage2> createState() => _MapPage2State();
}

class _MapPage2State extends State<MapPage2> {
  TextEditingController _addressController = TextEditingController();
  double lat = 0.0;
  double long = 0.0;
  String _currentLocation = '';
  late GoogleMapController mapController;
  LatLng initialLocation =
      const LatLng(10.77615745855286, 106.66759669033004); // Địa chỉ tọa độ ban đầu
  Set<Marker> markers = {}; // Set to hold markers
  //Convert latLng to String
  Future<String> _getCurrentLocation(LatLng location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      Placemark place = placemarks[0];
      // String ward = place.subLocality ?? place.subAdministrativeArea ?? '';
      _currentLocation =
          "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
      print(_currentLocation);
      return _currentLocation;
    } catch (e) {
      print(e);
      return '';
    }
  }

  // Convert String to latLng
  Future<void> _getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      Location location = locations[0];
      setState(() {
        lat = location.latitude;
        long = location.longitude;
        _currentLocation = address;
        initialLocation = LatLng(lat, long);
        print("$lat,$long,$_currentLocation");
      });
    } catch (e) {
      print(e);
    }
  }

  //Lấy địa chỉ từ GPS
  Future<Position> _getLiveLocation() async {
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
      lat = position.latitude;
      long = position.longitude;

      setState(() {
        initialLocation = LatLng(lat, long);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn từ bản đồ'),
      ),
      body: Consumer<ToolsVM>(
        builder: (context, value, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: 315,
                          child: TextFormField(
                            controller: _addressController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.go,
                            decoration: const InputDecoration(
                              hintText: 'Nhập địa chỉ',
                            ),
                            onFieldSubmitted: (value) async {
                              //chuyển đổi từ dạng địa chỉ thường sang dạng tọa độ
                              await _getLatLngFromAddress(value);
                              String address =
                                  await _getCurrentLocation(initialLocation);
                              setState(() {
                                _addressController.text = address;
                                // Update marker's position
                                markers.clear(); // Clear existing markers
                                markers.add(
                                  Marker(
                                    markerId: const MarkerId('NewLocation'),
                                    position: initialLocation,
                                    infoWindow: InfoWindow(
                                      title: address,
                                    ),
                                  ),
                                );

                                // Update camera's target
                                mapController.animateCamera(
                                  CameraUpdate.newLatLng(initialLocation),
                                );
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 55,
                          height: 65,
                          child: ElevatedButton(
                            onPressed: () async {
                              //chuyển đổi từ dạng tọa độ sang dạng địa chỉ
                              _getLiveLocation().then(
                                (value) {
                                  initialLocation =
                                      LatLng(value.latitude, value.longitude);
                                },
                              );
                              String address =
                                  await _getCurrentLocation(initialLocation);
                              setState(() {
                                _addressController.text = address;
                                markers.clear(); // Clear existing markers
                                markers.add(
                                  Marker(
                                    markerId: const MarkerId('NewLocation'),
                                    position: initialLocation,
                                    infoWindow: InfoWindow(
                                      title: address,
                                    ),
                                  ),
                                );

                                // Update camera's target
                                mapController.animateCamera(
                                  CameraUpdate.newLatLng(initialLocation),
                                );
                                // _addressController.text = " $lat,$long";
                                _addressController.text = _currentLocation;
                                print(_addressController.text);
                                // _addMarkerFromCurrentLocation();
                              });
                            },
                            child: const Icon(Icons.my_location),
                          ),
                        ),
                      ],
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
                  markers: {
                    Marker(
                      markerId: MarkerId('Googleplex'),
                      position: initialLocation,
                      infoWindow: const InfoWindow(
                        title: 'Googleplex',
                      ),
                    ),
                  },
                  circles: Set<Circle>.of(
                    <Circle>[
                      Circle(
                        circleId: const CircleId('location_circle'),
                        center: initialLocation,
                        radius: 100, // Replace with location accuracy
                        fillColor: Colors.blue.withOpacity(0.3),
                        strokeColor: Colors.blue,
                        strokeWidth: 1,
                      ),
                    ],
                  ),
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
                  onPressed: () {
                    value.addShipAddress(_currentLocation);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
