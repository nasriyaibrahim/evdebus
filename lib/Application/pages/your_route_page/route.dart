import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../widgets/animation widget/Route_painter_class/Route_painter_class.dart';
import '../../widgets/animation widget/Routestop_widget/rout_stop_widget.dart';

class RouteScreen extends StatefulWidget {
  final List<Map<String, dynamic>> matchedStops; // Including 'latitude' and 'longitude' for each stop

  const RouteScreen({Key? key, required this.matchedStops}) : super(key: key);

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Location location = Location();
  LocationData? _currentLocation;
  late StreamSubscription<LocationData> _locationSubscription;

  final List<String> stopTimes = [
    '06:30 PM', '06:45 PM', '07:00 PM', '07:15 PM', '07:30 PM', '08:00 PM',
    '08:15 PM', '08:30 PM', '08:45 PM', '09:00 PM', '09:15 PM', '09:30 PM',
    '09:45 PM', '10:00 PM', '10:15 PM', '10:30 PM', '10:45 PM', '11:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat(reverse: false);

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start location tracking
    _startLocationTracking();
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  // Start location tracking
  void _startLocationTracking() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationSubscription = location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentLocation = currentLocation;
      });
    });
  }

  // Convert degrees to radians
  double _degToRad(double deg) {
    return deg * (pi / 180);
  }

  // Calculate the distance between two points using Haversine formula
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double radius = 6371; // Earth radius in kilometers
    double dLat = _degToRad(lat2 - lat1);
    double dLon = _degToRad(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) * cos(_degToRad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return radius * c * 1000; // Distance in meters
  }

  // Get the closest stop index based on distance
  int _getClosestStopIndex() {
    if (_currentLocation == null) {
      return -1; // No location available
    }

    double currentLat = _currentLocation!.latitude!;
    double currentLon = _currentLocation!.longitude!;
    int closestStopIndex = -1;
    double closestDistance = double.infinity;

    for (int i = 0; i < widget.matchedStops.length; i++) {
      double stopLat = widget.matchedStops[i]['latitude'];
      double stopLon = widget.matchedStops[i]['longitude'];

      double distance = _calculateDistance(currentLat, currentLon, stopLat, stopLon);
      if (distance < 50 && distance < closestDistance) {
        closestDistance = distance;
        closestStopIndex = i;
      }
    }

    return closestStopIndex;
  }

  // Calculate the position of the bus based on the closest stop and its progress along the route
  double _calculateBusPosition() {
    if (_currentLocation == null) {
      return 0; // If no location data available, assume the bus is at the start
    }

    // Find the closest stop to the bus
    int closestStopIndex = _getClosestStopIndex();

    if (closestStopIndex == -1) {
      return 0; // No close stop found, bus is at the beginning
    }

    // Calculate the progress based on the closest stop index
    double progress = closestStopIndex / widget.matchedStops.length;

    return progress.clamp(0.0, 1.0); // Ensure progress stays between 0 and 1
  }

  @override
  Widget build(BuildContext context) {
    int stopCount = widget.matchedStops.length;
    double additionalHeight = 1068;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Your Route"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(height: 40),
                  Stack(
                    children: [
                      // Use AnimatedBuilder to rebuild the CustomPaint when animation changes
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: RoutePainter(
                              progress: _animation.value,
                              stopCount: stopCount,
                              additionalHeight: additionalHeight,
                            ),
                          );
                        },
                      ),
                      // Wrap RouteStop widgets inside an AnimatedBuilder
                      Column(
                        children: List.generate(
                          stopCount,
                              (index) {
                                String stopName = widget.matchedStops[index]['stopname'];
                            return AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return RouteStop(
                                  stopName,
                                  stopTimes.length > index ? stopTimes[index] : '09:00 PM',
                                  "On time",
                                  (index) * 1.0 / stopCount,  // Normalized stopProgress
                                  _animation.value,
                                );
                              },
                            );
                          },
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          // Calculate the position of the bus based on progress
                          double progress = _calculateBusPosition();
                          double topPosition = (1 + progress * (8 + additionalHeight));
                          return Positioned(
                            left: 92,
                            top: topPosition,
                            child: Icon(
                              Icons.directions_bus,
                              color: Colors.purple,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RouteStop extends StatelessWidget {
  final String matchedStop;
  final String time;
  final String status;
  final double stopProgress;
  final double currentProgress;

  RouteStop(this.matchedStop, this.time, this.status, this.stopProgress, this.currentProgress);

  @override
  Widget build(BuildContext context) {
    // Update circle color based on bus progress
    Color circleColor = currentProgress >= stopProgress ? Colors.purple : Colors.grey;

    // Position the circle correctly
    double stopPosition = stopProgress * 100;  // Adjust the multiplication factor for desired spacing

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(width: 40),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circle should reflect progress
                Icon(Icons.circle, color: circleColor, size: 12),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                matchedStop,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 40),
              child: Text(
                status,
                style: TextStyle(
                  color: status.contains("delay") ? Colors.red : Colors.green,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }
}

class RoutePainter extends CustomPainter {
  final double progress;
  final int stopCount;
  final double additionalHeight;

  RoutePainter({required this.progress, required this.stopCount, required this.additionalHeight});

  @override
  void paint(Canvas canvas, Size size) {
    Paint solidLinePaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 4;

    Paint dotPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double startY = 1;
    double stopHeight = (size.height + additionalHeight) / stopCount;
    double totalHeight = stopHeight * stopCount;

    double currentY = startY + progress * totalHeight;

    // Draw the solid and dotted lines
    for (int i = 0; i < stopCount; i++) {
      double y1 = startY + i * stopHeight;
      double y2 = y1 + stopHeight;

      if (currentY >= y2) {
        // Bus has passed this stop, draw solid line
        canvas.drawLine(Offset(107, y1), Offset(107, y2), solidLinePaint);
      } else if (currentY > y1 && currentY < y2) {
        // Bus is between two stops, draw solid line for passed portion
        double filledLength = currentY - y1;
        canvas.drawLine(Offset(107, y1), Offset(107, y1 + filledLength), solidLinePaint);

        // Draw dotted line for the remaining portion
        Path path = Path();
        path.moveTo(107, y1 + filledLength);
        path.lineTo(107, y2);

        double dashLength = 5;
        double dashSpace = 5;
        Path dashPath = Path();

        for (PathMetric pathMetric in path.computeMetrics()) {
          double distance = 0;
          while (distance < pathMetric.length) {
            dashPath.addPath(
                pathMetric.extractPath(distance, distance + dashLength),
                Offset.zero);
            distance += dashLength + dashSpace;
          }
        }
        canvas.drawPath(dashPath, dotPaint);
      } else {
        // Bus hasn't reached this stop, draw dotted line
        Path path = Path();
        path.moveTo(107, y1);
        path.lineTo(107, y2);

        double dashLength = 5;
        double dashSpace = 5;
        Path dashPath = Path();

        for (PathMetric pathMetric in path.computeMetrics()) {
          double distance = 0;
          while (distance < pathMetric.length) {
            dashPath.addPath(
                pathMetric.extractPath(distance, distance + dashLength),
                Offset.zero);
            distance += dashLength + dashSpace;
          }
        }
        canvas.drawPath(dashPath, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is RoutePainter && oldDelegate.progress != progress;
  }
}
