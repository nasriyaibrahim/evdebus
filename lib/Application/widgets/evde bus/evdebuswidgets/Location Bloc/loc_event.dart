abstract class LocationEvent {}

class UpdateLocations extends LocationEvent {
  final String from;
  final String destination;

  UpdateLocations({required this.from, required this.destination});
}

class SwapLocations extends LocationEvent {}
