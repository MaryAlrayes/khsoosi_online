import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/done_content_dialog.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/error_content_dialog.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/loading_content_dialog.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/core/utils/services/location_service.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/location/domain/entities/coords_entity.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/features/location/presentation/cubit/add_location_cubit.dart';
import 'dart:ui' as ui;
class LocationMapScreen extends StatefulWidget {
  const LocationMapScreen({super.key});

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  final int maxRadiusKM = 5;
  static final CURRENT_LOCATION = 'current_location';
  static final PREVIOUS_LOCATION = 'previous_location';
  static final NEW_SELECTED_LOCATION = 'new_selected_location';

  late LatLng? _userPreviousLocationCoords;
  late LatLng? _userCurrentLocationCoords;

  late CameraPosition _initialCameraPosition;
  GoogleMapController? _googleMapController;

  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};

  var _isLoading = true;

  CoordsEntity? selectedLocation;

 Future<Uint8List> _createCustomMarkerBitmap(String text) async {
final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = ColorManager.black;
    final double fontSize = 50.0;
    final double padding = 10.0;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
    );

    textPainter.layout();
    final double textWidth = textPainter.width;
    final double textHeight = textPainter.height;

    final double width = textWidth + 2 * padding;
    final double height = textHeight + 2 * padding;
    final double triangleHeight = 40.0;

    // Draw the background
    final RRect rRect = RRect.fromLTRBR(0, 0, width, height, Radius.circular(10));
    canvas.drawRRect(rRect, paint);

    // Draw the text
    textPainter.paint(canvas, Offset(padding, padding));

    // Draw the triangle
    final Path trianglePath = Path()
      ..moveTo(width / 2 - triangleHeight / 2, height)
      ..lineTo(width / 2 + triangleHeight / 2, height)
      ..lineTo(width / 2, height + triangleHeight)
      ..close();
    canvas.drawPath(trianglePath, paint);

    final ui.Image image = await pictureRecorder.endRecording().toImage(
          width.toInt(),
          (height + triangleHeight).toInt(),
        );

    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
  @override
  void initState() {
    super.initState();
    Marker? _currentLocationMarker;
    Marker? _previousLocationMarker;

    fetchLocation(context).then((_) async{
      if (_userCurrentLocationCoords != null) {
        _initialCameraPosition = CameraPosition(
          target: _userCurrentLocationCoords!,
          zoom: 13.0,
          tilt: 0,
          bearing: 0,
        );
        //marker for the user current location
        final Uint8List _currentLocationMarkerIcon = await _createCustomMarkerBitmap("أنت هنا حاليا");
        _currentLocationMarker = Marker(
            markerId: MarkerId(CURRENT_LOCATION),
            icon: BitmapDescriptor.fromBytes(_currentLocationMarkerIcon),

            draggable: false,
            position: _userCurrentLocationCoords!);
      }

      //marker for the user previous selected location
      if (_userPreviousLocationCoords != null) {
            final Uint8List _previousLocationMarkerIcon = await _createCustomMarkerBitmap("موقعك المحدد مسبقا");
        _previousLocationMarker = Marker(
            markerId: MarkerId(PREVIOUS_LOCATION),
            icon:BitmapDescriptor.fromBytes(_previousLocationMarkerIcon),
             draggable: false,
            position: _userPreviousLocationCoords!);
      }
      setState(() {
        if (_currentLocationMarker != null) {
          _markers.add(_currentLocationMarker!);
          _circles.add(
            Circle(
              circleId: CircleId('maxRadiusCircle'),
              center: LatLng(_userCurrentLocationCoords!.latitude,
                  _userCurrentLocationCoords!.longitude),
              radius: maxRadiusKM*1000, // Radius in meters (10 kilometers)
              fillColor: Colors.orange.withOpacity(0.3),
              strokeColor: Colors.orange,
              strokeWidth: 1,
            ),
          );
        }
        if (_previousLocationMarker != null)
          _markers.add(_previousLocationMarker!);
        _isLoading = false;
      });
    });
  }



  Future<void> fetchLocation(BuildContext context) async {
    if (context.read<AuthRepo>().getUserInfo()!.lat != 0 &&
        context.read<AuthRepo>().getUserInfo()!.lng != 0) {
      _userPreviousLocationCoords = LatLng(
        context.read<AuthRepo>().getUserInfo()!.lat,
        context.read<AuthRepo>().getUserInfo()!.lng,
      );
    }
    GeoLoc? res = await LocationService.getLocationCoords();
   if (res != null) {

      _userCurrentLocationCoords = LatLng(res.lat, res.lng);
    }
 }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<AddLocationCubit>(),
      child: Builder(builder: (context) {
        return BlocListener<AddLocationCubit, AddLocationState>(
          listener: (context, state) {
            _buildListener(state, context);
          },
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack(children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      onMapCreated: ((controller) {
                        _googleMapController = controller;

                      }),
                      initialCameraPosition: _initialCameraPosition,
                      markers: _markers,
                      circles: _circles,
                      onTap: (position) async{
                        if (_markers.contains(_markers.where((element) =>
                            element.markerId == NEW_SELECTED_LOCATION))) {
                          _markers.remove(_markers.where((element) =>
                              element.markerId == NEW_SELECTED_LOCATION));
                        }
                          final Uint8List _selectedLocationMarkerIcon = await _createCustomMarkerBitmap("الموقع");

                        Marker _selectedLocationMarker = Marker(
                            markerId: MarkerId(NEW_SELECTED_LOCATION),
                             draggable: true,
                            icon: BitmapDescriptor.fromBytes(_selectedLocationMarkerIcon),
                            position: position);

                        setState(() {
                          _markers.add(_selectedLocationMarker);
                          selectedLocation = CoordsEntity(
                            lat: position.latitude,
                            lng: position.longitude,
                          );

                          _googleMapController!.showMarkerInfoWindow(
                              MarkerId(NEW_SELECTED_LOCATION));
                        });
                      },
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: _buildTopCard(),
                    ),
                    if (selectedLocation != null) _buildSubmitBtn(context),
                  ]),
            // floatingActionButton: FloatingActionButton(
            //     backgroundColor: Colors.white,
            //     child: const Icon(
            //       Icons.my_location,
            //       color: Colors.black,
            //     ),
            //     onPressed: _isLoading
            //         ? null
            //         : () {
            //             _googleMapController?.animateCamera(
            //                 CameraUpdate.newCameraPosition(_initialCameraPosition));
            //           }),
          ),
        );
      }),
    );
  }

  Positioned _buildSubmitBtn(BuildContext context) {
    return Positioned(
      bottom: 8,
      left: 16,
      right: 16,
      child: SizedBox(
        height: 50,
        child: CustomElevatedButton(
          backgroundColor: ColorManager.black,
          label: 'تثبيت الموقع',
          onPressed: () {
            double distance = LocationService.calculateDistanceInKilo(
              lat1: _userCurrentLocationCoords!.latitude,
              lat2: selectedLocation!.lat,
              lng1: _userCurrentLocationCoords!.longitude,
              lng2: selectedLocation!.lng,
            );
            if (distance > maxRadiusKM) {
              showSnackbar(context,
                  'عليك تحديد موقعك في نطاق $maxRadiusKM كيلومتر كحد أقصى من موقعك الحالي');
            } else {
              BlocProvider.of<AddLocationCubit>(context).setLocation(
                  selectedLocation!, context.read<AuthRepo>().getUserId()!);
            }
          },
        ),
      ),
    );
  }

  void _buildListener(AddLocationState state, BuildContext context) {
    if (state.addLocationStatus == AddLocationStatus.loading) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(child: LoadingContentDialog(text: 'جاري تحديث موقعك'));
        },
      );
    } else if (state.addLocationStatus == AddLocationStatus.noInternet) {
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
              child: ErrorContentDialog(
            onPressed: () {
              BlocProvider.of<AddLocationCubit>(context).setLocation(
                  selectedLocation!, context.read<AuthRepo>().getUserId()!);
            },
            text: AppStrings.noInternetConnectionMessage,
          ));
        },
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else if (state.addLocationStatus == AddLocationStatus.networkError) {
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
              child: ErrorContentDialog(
            onPressed: () {
              BlocProvider.of<AddLocationCubit>(context).setLocation(
                  selectedLocation!, context.read<AuthRepo>().getUserId()!);
            },
            text: AppStrings.networkError,
          ));
        },
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else if (state.addLocationStatus == AddLocationStatus.done) {
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
              child: DoneContentDialog(
            text: 'تم تحديث موقعك بنجاح',
          ));
        },
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'تحديد الموقع الجغرافي',
      ),
    );
  }

  Container _buildTopCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(0),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
        ),
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              ' قم بتحديد موقعك على الخريطة عن طريق النقر على موقعك ومن ثم قم بالحفظ عبر الضغط على زر تثبيت الموقع بالأسفل.  عليك تحديد موقعك في نطاق $maxRadiusKM كيلومتر كحد أقصى من موقعك الحالي  ',
              style: TextStyle(fontSize: 12),
            ),
          ]),
        ),
      ),
    );
  }
}
