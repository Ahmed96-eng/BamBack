class AuthModelModel {
  UserData? data;
  AuthModelModel.fromJson(Map<String, dynamic> json) {
    data = UserData.fromJson(json['data']);
  }
}

class UserData {
  String? id;
  String? username;
  String? email;
  String? password;
  String? phone;
  String? profile;
  String? city;
  String? region;
  String? location;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    profile = json['profile'];
    city = json['city'];
    region = json['region'];
    location = json['location'];
  }
}
