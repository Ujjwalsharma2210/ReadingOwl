class User {
  final String username;
  final String email;
  final bool isVerifiedWriter = false;
  final List<dynamic> interests;
  final List<dynamic> yourBLogs = [];

  User({
    required this.username,
    required this.email,
    required this.interests,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'isVerifiedWriter': isVerifiedWriter,
        'interests': interests,
        'yourBlogs': yourBLogs,
      };
}
