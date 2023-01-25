class FaceBookLoginData {
  String? name;
  String? email;
  String? imageUrl;
  String? id;

  FaceBookLoginData(
      {required this.id,
      required this.email,
      required this.name,
      required this.imageUrl});

  FaceBookLoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];

    name = json['name'];
    imageUrl = json['picture']['url'];
  }
}

class FacebookData {
  static List<FaceBookLoginData> data = [
    FaceBookLoginData(id: "da", email: "d", name: "sda", imageUrl: "af")
  ];
}
