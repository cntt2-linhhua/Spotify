import 'package:dartz/dartz.dart';
import 'package:shopify/data/models/auth/create_user_req.dart';
import 'package:shopify/data/models/auth/signin_user_req.dart';

abstract class AuthRespository {
  Future<Either> signup(CreateUserReq ceateUserReq);

  Future<Either> signin(SigninUserReq signinUserReq);

  Future<Either> getUser();
}
