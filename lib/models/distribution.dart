class Distribution {
  final int id;
  final String name;
  final String description;
  final String? logoUrl;
  final String? desktopImageUrl;

  Distribution({
    required this.id,
    required this.name,
    required this.description,
    this.logoUrl,
    this.desktopImageUrl,
  });

  factory Distribution.fromJson(Map<String, dynamic> json) {
    return Distribution(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      logoUrl: json['logoUrl'],
      desktopImageUrl: json['desktopImageUrl'],
    );
  }
}
