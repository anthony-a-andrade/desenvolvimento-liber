class FileResponseDTO {
  String? token;
  String? email;
  String? name;
  String? password;

  FileResponseDTO.register(dynamic json) {
    token = json["token"];
    name = json["name"];
    email = json["email"];
  }

  FileResponseDTO.recover(dynamic json) {
    token = json["token"];
    email = json["email"];
  }

  FileResponseDTO.login(dynamic json) {
    email = json["email"];
    password = json["password"];
  }
}