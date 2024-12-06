
class LocationState {
  final String from;
  final String destination;

  LocationState({required this.from, required this.destination});

  LocationState copyWith({String? from, String? destination}) {
    return LocationState(
      from: from ?? this.from,
      destination: destination ?? this.destination,
    );
  }
}
