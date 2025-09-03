import 'package:dartz/dartz.dart';
import 'package:shopify/core/usecase/usecase.dart';
import 'package:shopify/data/models/auth/create_user_req.dart';
import 'package:shopify/domain/respository/auth/auth.dart';
import 'package:shopify/service_locator.dart';

class SignupUseCase implements UseCase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) {
    return sl<AuthRespository>().signup(params!);
  }
}