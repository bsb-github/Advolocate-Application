class AdvocatesData {
  final String email;
  final int uid;
  final String name;
  final String address;
  final String extra_contact_info;
  final String languages;
  final int status;
  final String services;
  final String contact;
  final String coveredArea;
  final String probono;
  final String city;
  final String profession;
  final String country;

  AdvocatesData(
      {required this.email,
      required this.probono,
      required this.uid,
      required this.contact,
      required this.name,
      required this.address,
      required this.extra_contact_info,
      required this.languages,
      required this.status,
      required this.coveredArea,
      required this.services,
      required this.city,
      required this.country,
      required this.profession});
  int get Uid => this.uid;
  static AdvocatesData fromJson(Map<String, dynamic> Json) {
    return AdvocatesData(
      coveredArea: Json["covered_area"] ?? "",
      email: Json["email"] ?? "",
      uid: Json["user_id"] ?? "",
      name: Json["name"] ?? "",
      address: Json["address"] ?? "",
      country: Json["country"] ?? "",
      extra_contact_info: Json["extra_contact_info"] ?? "",
      languages: Json["languages"] ?? "",
      status: Json["status"] ?? 2,
      services: Json["services"] ?? "",
      contact: Json["contact_number"] ?? "",
      probono: Json["probono"] != 1 ? "Paid" : "Free",
      city: Json["city"] ?? "",
      profession: Json["profession"] ?? "",
    );
  }
}

class AdvocatesList {
  static List<AdvocatesData> data = [];
}
