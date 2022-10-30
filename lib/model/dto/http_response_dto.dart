class HttpResponseDTO {
  String? token;
  String? message;
  String? name;
  int status;

  HttpResponseDTO.register(this.token, this.message, this.status);
  HttpResponseDTO.validate(this.message, this.status);
  HttpResponseDTO.login(this.name, this.message, this.status);
  HttpResponseDTO.forgotPassword(this.token, this.message, this.status);
  HttpResponseDTO.changePassword(this.message, this.status);
}