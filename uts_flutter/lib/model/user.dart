class User {
  final String email;
  final String name;
  final String password;
  final String dateBirth;
  const User(
      {required this.email,
      required this.name,
      required this.password,
      required this.dateBirth});

  static User fromJson(Map<String, dynamic> json) => User(
      email: json['email'],
      name: json['name'],
      password: json['password'],
      dateBirth: json['dateBirth']);

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'password': password,
        'dateBirth': dateBirth,
      };
}
