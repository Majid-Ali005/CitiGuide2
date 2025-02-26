class City {
  final String id;
  final String name;
  final String description;
  final String openHours;
  final String contactNumber;
  final String imageUrl;

  City({
    required this.id,
    required this.name,
    required this.description,
    required this.openHours,
    required this.contactNumber,
    required this.imageUrl,
  });

  factory City.fromMap(Map<String, dynamic> data, String id) {
    return City(
      id: id,
      name: data['name'],
      description: data['description'],
      openHours: data['openHours'],
      contactNumber: data['contactNumber'],
      imageUrl: data['imageUrl'],
    );
  }
}