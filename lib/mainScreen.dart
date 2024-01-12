import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  MapSampleState createState() => MapSampleState();
}

class MapSampleState extends State<MainScreen> {
  late GoogleMapController mapController;

  // Sample MULTIPOLYGON data
  String multipolygonData = "MULTIPOLYGON (((97.82177947697042 1.010626179846118, 97.82208722227087 1.004768889173989, 97.82021055573101 0.997908332832474, 97.8171282697698 0.99267333073657, 97.8170900000201 0.992608333136201, 97.81663222172483 0.991833333384183, 97.81202444368438 0.986362778164428, 97.8116811113119 0.984594999737141, 97.81164644604497 0.984608891564563, 97.80548555594697 0.987077777848509, 97.79815388886101 0.987851666937765, 97.79309555587982 0.988646666712399, 97.7930704441108 0.988563226715176, 97.79303538404146 0.988615816369497, 97.79186584991653 0.990175194902819, 97.79082626422762 0.991344729027742, 97.79134605707212 0.992644210689218, 97.79056636825506 0.994853331402333, 97.79030647138322 0.997842140932513, 97.79017652294729 1.000571053590758, 97.79056636825506 1.001480691743027, 97.79108616109956 1.002260380560092, 97.79082626422762 1.003949708428707, 97.79056636825506 1.006158828242453, 97.7904338207785 1.006341080348304, 97.79061876185722 1.006366589617667, 97.81069200366917 1.007780197942641, 97.81790140702587 1.012021023816932, 97.82014404816897 1.013976815406946, 97.82177947697042 1.010626179846118)))";

  List<LatLng> parseMultipolygon(String multipolygonData) {
    // Implement your parsing logic here based on the MULTIPOLYGON format
    // For example, you might need to split the data and convert it into LatLng list
    // This is a simple example, you might need to handle different cases
    // and adapt it to your specific data format.
    
    // Split by "(((" and remove ")))" at the end
    String coordinatesString = multipolygonData.split("(((")[1].replaceAll(")))", "");

    List<LatLng> coordinatesList = coordinatesString.split(",").map((coord) {
      List<String> latLng = coord.trim().split(" ");
      return LatLng(double.parse(latLng[1]), double.parse(latLng[0]));
    }).toList();

    return coordinatesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Map with MULTIPOLYGON'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
          List<LatLng> multipolygonCoordinates = parseMultipolygon(multipolygonData);
          mapController.animateCamera(
            CameraUpdate.newLatLngBounds(
              LatLngBounds(
                southwest: multipolygonCoordinates.reduce((value, element) => LatLng(
                    value.latitude < element.latitude ? value.latitude : element.latitude,
                    value.longitude < element.longitude ? value.longitude : element.longitude)),
                northeast: multipolygonCoordinates.reduce((value, element) => LatLng(
                    value.latitude > element.latitude ? value.latitude : element.latitude,
                    value.longitude > element.longitude ? value.longitude : element.longitude)),
              ),
              10.0,
            ),
          );
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 2.0,
        ),
        polygons: <Polygon>{
          Polygon(
            polygonId: PolygonId("multipolygon"),
            points: parseMultipolygon(multipolygonData),
            strokeWidth: 2,
            strokeColor: Colors.blue,
            fillColor: Colors.blue.withOpacity(0.3),
          ),
        },
      ),
    );
  }
}