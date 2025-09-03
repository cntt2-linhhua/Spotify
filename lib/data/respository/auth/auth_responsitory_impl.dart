import 'package:dartz/dartz.dart';
import 'package:shopify/data/models/auth/create_user_req.dart';
import 'package:shopify/data/models/auth/signin_user_req.dart';
import 'package:shopify/data/sources/auth/auth_firebase_service.dart';
import 'package:shopify/domain/respository/auth/auth.dart';
import 'package:shopify/service_locator.dart';

class AuthResponsitoryImpl extends AuthRespository {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq ceateUserReq) async {
    return await sl<AuthFirebaseService>().signup(ceateUserReq);
  }
  
  @override
  Future<Either> getUser() async {
    return await sl<AuthFirebaseService>().getUser();
  }
}