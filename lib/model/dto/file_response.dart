class FileResponse {
  String? token;
  String? email;
  String? name;
  String? password;
  bool? interests;

  FileResponse.register(dynamic json) {
    token = json["token"];
    name = json["name"];
    email = json["email"];
  }

  FileResponse.interests(dynamic json) {
    email = json["email"];
    password = json["password"];
    interests = json["interests"];
  }

  FileResponse.recover(dynamic json) {
    token = json["token"];
    email = json["email"];
  }

  FileResponse.login(dynamic json) {
    email = json["email"];
    password = json["password"];
  }
}