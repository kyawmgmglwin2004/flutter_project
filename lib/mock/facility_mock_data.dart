import 'dart:async';

class Facility {
  final String id;
  final String name;
  final String location;

  Facility({required this.id, required this.name, required this.location});
}

List<Facility> mockFacilities = [
  Facility(id: "123456", name: "Tokyo Hospital", location: "Tokyo"),
  Facility(id: "654321", name: "Osaka Clinic", location: "Osaka"),
  Facility(id: "111222", name: "Kyoto Medical", location: "Kyoto"),
];

Future<Facility?> fetchFacility(String id) async {
  await Future.delayed(const Duration(seconds: 1));

  try {
    return mockFacilities.firstWhere((f) => f.id == id);
  } catch (e) {
    return null; // Not found
  }
}
