class UserSignupModel {
  String email;
  String password;
  String userName;

  UserSignupModel({
    required this.email,
    required this.password,
    required this.userName,
  });

  factory UserSignupModel.fromJson(Map<String, dynamic> json) {
    return UserSignupModel(
      email: json['email'],
      password: json['password'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'userName': userName,
    };
  }
}
