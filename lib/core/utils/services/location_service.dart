import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static Future<GeoLoc?> getLocationCoords() async {
    print('hi from top loc service');
    try {
      LocationPermission status = await Geolocator.checkPermission();
      print('hi statuse $status');
      if (status == LocationPermission.whileInUse ||
          status == LocationPermission.always) {
        try {
          print('hi from loc service');
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          GeoLoc geoLoc = GeoLoc(
            lng: position.longitude,
            lat: position.latitude,
          );

          print('lng ${position.longitude} lat ${position.latitude}');
          return geoLoc;
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          rethrow;
        }
      } else {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.location,
        ].request();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}

class GeoLoc {
  late double lat;
  late double lng;

  GeoLoc({required this.lat, required this.lng});

  GeoLoc.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
