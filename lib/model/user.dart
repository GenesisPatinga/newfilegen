
class User {
  final String username;
  final String email;
  final String urlAvatar;

  const User({
    required this.username,
    required this.email,
    required this.urlAvatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String? ?? 'Unknown User',
      email: json['email'] as String? ?? 'No email',
      urlAvatar: json['urlAvatar'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'urlAvatar': urlAvatar,
    };
  }
}
