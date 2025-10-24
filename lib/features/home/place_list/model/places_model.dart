class SpaceModel {
  final String spaceId;
  final String title;
  final String subTitle;
  final String description;
  final String guidelines;
  final double price;
  final int capacity;
  final List<String> images;
  final List<String> amenities;
  final String? ownerId;

  SpaceModel({
    required this.spaceId,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.guidelines,
    required this.price,
    required this.capacity,
    required this.images,
    required this.amenities,
    this.ownerId,
  });

  factory SpaceModel.fromJson(Map<String, dynamic> json) {
    return SpaceModel(
      spaceId: json['id'] ?? '',
      title: json['title'] ?? 'Untitled Space',
      subTitle: json['subTitle'] ?? '',
      description: json['description'] ?? '',
      guidelines: json['guidelines'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      capacity: json['capacity'] ?? 0,
      images: List<String>.from(json['images'] ?? []),
      amenities: List<String>.from(json['amenities'] ?? []),
      ownerId: json['ownerId'],
    );
  }
}
