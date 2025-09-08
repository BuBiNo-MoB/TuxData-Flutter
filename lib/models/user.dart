class User {
  final int id;
  final String firstName;
  final String lastName;
  final String password;
  final String? avatar;
  final String email;
  final String username;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.password,
      this.avatar,
      required this.email,
      required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      password: json['password'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'avatar': avatar,
      'email': email,
      'username': username,
    };
  }
}
