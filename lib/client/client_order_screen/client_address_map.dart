import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class ClientShowMapScreen extends StatefulWidget {
  const ClientShowMapScreen({super.key});

  @override
  State<ClientShowMapScreen> createState() => _ClientShowMapScreenState();
}

class _ClientShowMapScreenState extends State<ClientShowMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GoogleMap(
      initialCameraPosition: CameraPosition(target: LatLng(15.5527,48.5164),
      ),

    ),);
  }
}