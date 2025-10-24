class ProfileModel {
  final String? fullName;
  final String? email;
  final String? avatar;
  final String? role;

  ProfileModel({
    this.fullName,
    this.email,
    this.avatar,
    this.role,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] as String?, 
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'avatar': avatar,
      'role': role,
    };
  }
}
