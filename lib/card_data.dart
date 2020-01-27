import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

class CardData extends StatelessWidget {
  final double magnitude;
  final String place;
  final String date;
  final String id;

  CardData(
      {@required this.magnitude,
      @required this.place,
      @required this.date,
      @required this.id});

  @override
  Widget build(BuildContext context) {
    // Completer<GoogleMapController> _controller = Completer();
    // final CameraPosition _kLake = CameraPosition(
    //     bearing: 192.8334901395799,
    //     target: LatLng(geometry['coordinates'][0], geometry['coordinates'][1]),
    //     tilt: 59.440717697143555,
    //     zoom: 19.151926040649414);
    final String splitPosition = 'of ';
    // Future<void> _goToTheLake() async {
    //   final GoogleMapController controller = await _controller.future;
    //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    // }

    // _goToTheLake();

    String placeDistance;
    String placeName;

    List<Color> magnitudeColor = [
      Color(0xFF04B4B3),
      Color(0xFF10CAC9),
      Color(0xFFF5A623),
      Color(0xFFFF7D50),
      Color(0xFFFC6644),
      Color(0xFFE75F40),
      Color(0xFFE13A20),
      Color(0xFFD93218),
    ];

    if (place.contains(splitPosition)) {
      List subString = place.split(splitPosition);
      placeDistance = subString[0];
      placeName = subString[1];
    } else {
      placeDistance = 'NEAR ';
      placeName = place;
    }

//Rowu bir Column içine al
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      decoration: BoxDecoration(
          color: magnitudeColor[magnitude.toInt()],
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: <Widget>[
          //Resimleri için container
          ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                  width: 400,
                  height: 200,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      // child: Text(widget.geometry['coordinates'][0].toString()),
                      child: WebView(
                        initialUrl:
                            'https://earthquake.usgs.gov/earthquakes/eventpage/$id/map',
                        javascriptMode: JavascriptMode.unrestricted,
                      )
                      // GoogleMap(
                      //   mapType: MapType.normal,
                      //   initialCameraPosition: CameraPosition(
                      //     target: LatLng(geometry['coordinates'][0],
                      //         geometry['coordinates'][1]),
                      //     zoom: 1,
                      //   ),
                      //   onMapCreated: (GoogleMapController controller) {
                      //     _controller.complete(controller);
                      //   },
                      // ),
                      ))),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.black26,
                  child: Text(
                    magnitude.toStringAsFixed(1),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          (placeDistance + splitPosition).toUpperCase(),
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          placeName,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
