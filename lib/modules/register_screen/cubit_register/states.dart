
import 'package:shopapp/models/login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegiterInitialStates extends ShopRegisterStates{}

class ShopRegiterLoadingStates extends ShopRegisterStates{}


class ShopRegisterSuccessfulStates extends ShopRegisterStates
{
  final ShopLoginModel loginModel ;

  ShopRegisterSuccessfulStates(this.loginModel);
}


class ShopRegisterErrorStates extends ShopRegisterStates
{
  final String error;
  ShopRegisterErrorStates(this.error);
}

class ShopRegisterSuffixChangeStates extends ShopRegisterStates{}
