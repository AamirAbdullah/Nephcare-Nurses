class UserModel {
  final int requestId;
  final String userName;
  final String requestStatus;
  final int? testStatus;
  final String? phoneno;
  final String email;
  final int paymentstatus;

  UserModel(
      {required this.requestId,
      required this.userName,
      required this.requestStatus,
      this.testStatus,
      required this.paymentstatus,
      this.phoneno,
      required this.email});
}
