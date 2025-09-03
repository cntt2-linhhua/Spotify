import 'package:dartz/dartz.dart';
import 'package:shopify/core/usecase/usecase.dart';
import 'package:shopify/data/models/auth/signin_user_req.dart';
import 'package:shopify/domain/respository/auth/auth.dart';
import 'package:shopify/service_locator.dart';

class SigninUseCase implements UseCase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) {
    return sl<AuthRespository>().signin(params!);
  }
}