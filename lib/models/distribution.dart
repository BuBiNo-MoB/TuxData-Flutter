class Distribution {
  final int id;
  final String name;
  final String currentVersion;
  final DateTime? releaseDate;
  final String description;
  final String officialWebsite;
  final String baseDistro;
  final String supportedArchitecture;
  final String packageType;
  final String desktopEnvironment;
  final String? logoUrl;
  final String? desktopImageUrl;
  final int likes;

  Distribution({
    required this.id,
    required this.name,
    required this.currentVersion,
    this.releaseDate,
    required this.description,
    required this.officialWebsite,
    required this.baseDistro,
    required this.supportedArchitecture,
    required this.packageType,
    required this.desktopEnvironment,
    this.logoUrl,
    this.desktopImageUrl,
    required this.likes,
  });

  factory Distribution.fromJson(Map<String, dynamic> json) {
    return Distribution(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      currentVersion: json['currentVersion'] ?? '',
      releaseDate: json['releaseDate'] != null
          ? DateTime.parse(json['releaseDate'])
          : null,
      description: json['description'] ?? '',
      officialWebsite: json['officialWebsite'] ?? '',
      baseDistro: json['baseDistro'] ?? '',
      supportedArchitecture: json['supportedArchitecture'] ?? '',
      packageType: json['packageType'] ?? '',
      desktopEnvironment: json['desktopEnvironment'] ?? '',
      logoUrl: json['logoUrl'],
      desktopImageUrl: json['desktopImageUrl'],
      likes: json['likes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'currentVersion': currentVersion,
      'releaseDate': releaseDate?.toIso8601String(),
      'description': description,
      'officialWebsite': officialWebsite,
      'baseDistro': baseDistro,
      'supportedArchitecture': supportedArchitecture,
      'packageType': packageType,
      'desktopEnvironment': desktopEnvironment,
      'logoUrl': logoUrl,
      'desktopImageUrl': desktopImageUrl,
      'likes': likes,
    };
  }
}
