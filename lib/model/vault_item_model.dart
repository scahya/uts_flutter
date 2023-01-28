class VaultItemModel {
  final String title;
  final String username;
  final String password;
  final String comment;
  final String id;
  final String vaultId;
  final String createdAt;
  const VaultItemModel({
    required this.title,
    required this.username,
    required this.password,
    required this.comment,
    required this.id,
    required this.vaultId,
    required this.createdAt,
  });

  factory VaultItemModel.fromJson(Map<String, dynamic> json) {
    return VaultItemModel(
      title: json['title'],
      username: json['username'],
      password: json['password'],
      createdAt: json['createdAt'],
      id: json['id'],
      vaultId: json['vaultId'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'username': username,
        'password': password,
        'createdAt': createdAt,
        'id': id,
        'vaultId': vaultId,
        'comment': comment,
      };
}
