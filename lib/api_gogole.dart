import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'package:flutter/services.dart';
import 'package:google_places_flutter/model/prediction.dart' hide Prediction;

const String GOOGLE_MAPS_API_KEY = "AIzaSyBGq4gmZXERfn7DPa_k00w18sN4YNUj6Ts";

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
 final LatLng _center = const LatLng(37.7749, -122.4194); // San Francisco
final places = GoogleMapsPlaces(apiKey: GOOGLE_MAPS_API_KEY);
Set<Marker> markers = {};

void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
}

Future<void> _searchLocation() async {
    try {
        Prediction? prediction = await PlacesAutocomplete.show(
            context: context,
            apiKey: GOOGLE_MAPS_API_KEY,
            mode: Mode.overlay,
            language: 'en',
            components: [Component(Component.country, 'us')],
        );

        if (prediction != null) {
            PlacesDetailsResponse detail = await places.getDetailsByPlaceId(prediction.placeId!);
            final lat = detail.result.geometry!.location.lat;
            final lng = detail.result.geometry!.location.lng;

            setState(() {
                markers.clear();
                markers.add(
                    Marker(
                        markerId: MarkerId(prediction.placeId!),
                        position: LatLng(lat, lng),
                        infoWindow: InfoWindow(
                            title: prediction.description,
                            snippet: 'Searched Location',
                        ),
                    ),
                );

                mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0),
                );
            });
        }
    } catch (e) {
        print(e);
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps in Flutter'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchLocation,
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: markers,
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Search for a location!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}