import 'dart:math' as Math;

import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

const earthRadius = 6371e3; //metre

/// calculate square of sin : sin²
/// [x] : (num) number that you want to calculate it's sin²
double sqrtSin(num x) {
  return Math.sin(x) * Math.sin(x);
}

/// calculate square of cos : cos²
/// [x] : (num) number that you want to calculate it's cos²
double sqrtCos(num x) {
  return Math.cos(x) * Math.cos(x);
}

/// calculate multiplication of cos : cos x * cos y
/// [x] : (num) number of the first cos
/// [x] : (num) number of second cos
double sqrtCos2(num x, num y) {
  return Math.cos(x) * Math.cos(y);
}

/// calculate approximately distance between two geographique point using  haversine formula
/// fore more detail @link: https://www.movable-type.co.uk/scripts/latlong.html
/// return value in metres
/// [p1] : (GeoPoint) first point in road
/// [p2] : (GeoPoint) last point in road
Future<double> distance2point(GeoPoint p1, GeoPoint p2) async {
  final phi1 = p1.latitude * Math.pi / 180; // φ, λ in radians
  final phi2 = p2.latitude * Math.pi / 180;
  final deltaPhi = (p2.latitude - p1.latitude) * Math.pi / 180;
  final deltaLambda = (p2.longitude - p1.longitude) * Math.pi / 180;

  final double a =
      sqrtSin(deltaPhi / 2) + sqrtCos2(phi1, phi2) * sqrtSin(deltaLambda / 2);

  final double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

  return earthRadius * c; //metres
}
