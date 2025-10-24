class NewProfileModel {
  final String fullName;
  final String email;
  final String? avatar;
  final String role;

  NewProfileModel({
   required this.fullName,
   required this.email,
   required this.avatar,
   required this.role,
  });

  factory NewProfileModel.fromJson(Map<String, dynamic> json) {
    return NewProfileModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      role: json['role'] ?? '',
    );
  }
}