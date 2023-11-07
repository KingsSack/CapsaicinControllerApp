import 'package:flutter/material.dart';

class Destination {
  const Destination(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<Destination> destinations = <Destination>[
  Destination(Icons.space_dashboard_outlined, 'Dashboard'),
  Destination(Icons.list_alt_rounded, 'Information'),
  Destination(Icons.settings_outlined, 'Settings'),
];