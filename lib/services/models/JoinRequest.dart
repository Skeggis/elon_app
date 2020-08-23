class JoinRequest {
  String uuid;
  int id;
  String name;
  String photoUrl;
  int organizationId;

  JoinRequest(
      {this.uuid, this.id, this.name, this.photoUrl, this.organizationId});

  factory JoinRequest.fromJson(Map<String, dynamic> json) {
    print("JoinRequestJSON");
    return JoinRequest(
      uuid: json['uuid'],
      id: json['id'],
      name: json['name'],
      photoUrl: json['photo_url'],
      organizationId: json['organization_id'],
    );
  }
}
