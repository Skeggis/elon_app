class Organization {
  String id;
  String name;
  String imageUrl;
  Organization({this.name, this.imageUrl, this.id});

  factory Organization.fromJson(dynamic json) {
    return Organization(
      name: json['name'] as String,
      id: json['id'] as String,
      imageUrl: json['image'] as String,
    );
  }
}
