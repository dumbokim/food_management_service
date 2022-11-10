import 'package:flutter/cupertino.dart';
import 'package:food_management_service/pages/splash/splash_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(foodRepository);
    final restaurantList = repository.getRestaurantList;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('지도'),
      ),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/spin.gif')),
        ),
        child: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.499248, 127.0359492),
              zoom: 17,
            ),
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            markers: restaurantList
                .map((e) => Marker(
                      markerId: MarkerId(e.name),
                      position: LatLng(e.latitude, e.longitude),
                      infoWindow: InfoWindow(
                        title: e.name,
                        snippet: e.description,
                      ),
                    ))
                .toSet()),
      ),
    );
  }
}
