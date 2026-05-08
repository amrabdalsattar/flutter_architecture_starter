class CreatedBy {
  final String id;
  final String name;
  final String? profilePic;

  const CreatedBy({required this.id, required this.name, this.profilePic});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'],
      name: json['name'] ?? '',
      profilePic: json['profilePic'],
    );
  }
}
