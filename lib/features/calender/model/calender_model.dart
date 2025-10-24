class Booking {
  final String id;
  final String status;
  final double amount;
  final String startTime;
  final String endTime;
  final Space space;

  Booking({
    required this.id,
    required this.status,
    required this.amount,
    required this.startTime,
    required this.endTime,
    required this.space,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      status: json['status'] ?? 'PENDING',
      amount: (json['amount'] ?? 0).toDouble(),
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      space: Space.fromJson(json['space'] ?? {}),
    );
  }
}

class Space {
  final String title;
  final List<String> images;

  Space({required this.title, required this.images});

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      title: json['title'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }
}
