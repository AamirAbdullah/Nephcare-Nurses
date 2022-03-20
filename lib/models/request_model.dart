class RequestModel {
  final String? image;
  final int id;
  final String username;
  final String? phoneno;
  final String email;
  RequestModel({
    this.image,
    required this.id,
    required this.username,
    required this.email,
    this.phoneno,
  });
}
