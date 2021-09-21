class ProfilModel {
  ProfileData? data;
  ProfilModel.fromJson(Map<String, dynamic> json) {
    data = ProfileData.fromJson(json['data']);
  }
}

class ProfileData {
  String? id;
  String? username;
  String? email;
  String? phone;
  String? profileImage;
  String? city;
  String? region;
  String? location;

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    profileImage = json['profile'];
    city = json['city'];
    region = json['region'];
    location = json['location'];
  }
}
