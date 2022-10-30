class FileResponseDTO {
  FileResponseType? type;
  String? token;
  String? email;
  String? name;

  FileResponseDTO.register(dynamic json) {
    type = FileResponseType.register;
    token = json["token"];
    name = json["name"];
    email = json["email"];
  }

  FileResponseDTO.recover(dynamic json) {
    type = FileResponseType.recover;
    token = json["token"];
    email = json["email"];
  }
}

enum FileResponseType {
  register,
  recover
}