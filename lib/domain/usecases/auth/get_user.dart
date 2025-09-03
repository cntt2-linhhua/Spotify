import 'package:dartz/dartz.dart';
import 'package:shopify/core/usecase/usecase.dart';
import 'package:shopify/domain/respository/auth/auth.dart';
import 'package:shopify/service_locator.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await sl<AuthRespository>().getUser();
  }
}