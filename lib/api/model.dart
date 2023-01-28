class Mahasiswa {
  final String address;
  final String id;
  final String name;

  const Mahasiswa({
    required this.address,
    required this.id,
    required this.name,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      address: json['address'],
      id: json['id'],
      name: json['name'],
    );
  }
}
