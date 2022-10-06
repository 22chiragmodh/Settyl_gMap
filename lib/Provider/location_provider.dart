import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  Location? _location;
  Location? get location => _location;
  LatLng? _locationposition;
  LatLng? get locationposition => _locationposition;
  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  BitmapDescriptor? _locationicon;

  Map<MarkerId, Marker>? _markers;
  Map<MarkerId, Marker>? get markers => _markers;

  bool locationServiceActive = true;
  BitmapDescriptor? get locationicon => _locationicon;
  final MarkerId markerId = MarkerId('1');

  LocationProvider() {
    _location = new Location();
    _markers = <MarkerId, Marker>{};
  }

  initalization() async {
    await getUserLocation();
    await setCustomMapPin();
  }

  getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissiongranted;

    _serviceEnabled = await location!.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location!.requestService();

      if (!_serviceEnabled) {
        return;
      }
    }

    _permissiongranted = await location!.hasPermission();

    if (_permissiongranted == PermissionStatus.denied) {
      _permissiongranted = await location!.requestPermission();

      if (_permissiongranted != PermissionStatus.granted) {
        return;
      }
    }

    location!.onLocationChanged.listen(
      (LocationData curlocation) {
        _locationposition = LatLng(curlocation.latitude!.toDouble(),
            curlocation.longitude!.toDouble());

        print(_locationposition);

        _markers!.clear();

        Marker marker = Marker(
            markerId: markerId,
            position: LatLng(
              _locationposition!.latitude,
              _locationposition!.longitude,
            ),
            // icon: locationicon,
            draggable: true,
            onDragEnd: ((newPosition) {
              _locationposition = LatLng(
                newPosition.latitude,
                newPosition.longitude,
              );

              notifyListeners();
            }));
        _markers![markerId] = marker;

        notifyListeners();
      },
    );
  }

  setMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  setCustomMapPin() async {
    _locationicon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/images/destination_map_marker.png',
    );
  }

  takeSnapshot() {
    return _mapController!.takeSnapshot();
  }
}
