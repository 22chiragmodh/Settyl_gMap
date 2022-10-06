import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:settyl_intern/Provider/location_provider.dart';
import 'package:provider/provider.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initalization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Map Live Location"),
          backgroundColor: Colors.redAccent,
        ),
        body: googleMapUi());
  }

  Widget googleMapUi() {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      if (model.locationposition != null) {
        return Column(children: [
          Expanded(
              child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(model.locationposition!.latitude,
                    model.locationposition!.longitude),
                zoom: 18),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: Set<Marker>.of(model.markers!.values),
            onMapCreated: (GoogleMapController controller) {
              Provider.of<LocationProvider>(context, listen: false)
                  .setMapController(controller);
            },
          ))
        ]);
      }
      return Container(child: Center(child: CircularProgressIndicator()));
    });
  }
}
