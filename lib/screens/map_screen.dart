import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import '../providers/app_provider.dart';
import 'place_detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late AppleMapController _mapController;
  final Set<Annotation> _annotations = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _createAnnotations();
    });
  }

  void _createAnnotations() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    setState(() {
      _annotations.clear();
      for (final place in provider.places) {
        _annotations.add(
          Annotation(
            annotationId: AnnotationId(place.id),
            position: LatLng(place.latitude, place.longitude),
            infoWindow: InfoWindow(
              title: place.name,
              snippet: place.location,
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => PlaceDetailScreen(place: place),
                  ),
                );
              },
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final places = provider.places;

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF1C1C24),
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color(0xFF232332),
        border: null,
        middle: Text(
          'Map View',
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Apple Maps
            Container(
              height: 320,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black.withAlpha(51),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AppleMap(
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(26.8206, 30.8025), // Center of Egypt
                    zoom: 5.5,
                  ),
                  annotations: _annotations,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  mapType: MapType.standard,
                ),
              ),
            ),
            // Locations list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Locations',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${places.length} places',
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: places.length,
                itemBuilder: (context, index) {
                  final place = places[index];
                  return GestureDetector(
                    onTap: () {
                      // Move camera to place
                      _mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(place.latitude, place.longitude),
                            zoom: 12.0,
                          ),
                        ),
                      );
                      // Navigate to detail
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => PlaceDetailScreen(place: place),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF232332),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            place.imageEmoji,
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  place.name,
                                  style: const TextStyle(
                                    color: CupertinoColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.location_solid,
                                      size: 12,
                                      color: Color(0xFF9E9E9E),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        place.location,
                                        style: const TextStyle(
                                          color: Color(0xFF9E9E9E),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            CupertinoIcons.location_fill,
                            color: CupertinoColors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
