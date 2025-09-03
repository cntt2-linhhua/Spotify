import 'package:shopify/domain/entities/auth/user.dart';

class UserModel {
  String? email;
  String? fullName;
  String? imageURL;

  UserModel({
    required this.email,
    required this.fullName,
    required this.imageURL
  });

  UserModel.fromJon(Map<String, dynamic> data) {
    email = data['email'];
    fullName = data['name'];
    // imageURL = data['imageURL'];
  }
}

extension UserModalX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      fullName: fullName,
      imageURL: imageURL,
    );
  }
}
