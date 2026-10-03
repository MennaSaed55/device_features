import 'package:flutter/material.dart';

class MapMarkerInfo extends StatelessWidget {
  const MapMarkerInfo({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Colors.red),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
