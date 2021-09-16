
import 'package:shopapp/models/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialStates extends ShopLoginStates{}

class ShopLoginLoadingStates extends ShopLoginStates{}


class ShopLoginSuccessfulStates extends ShopLoginStates
{
  final ShopLoginModel loginModel ;

  ShopLoginSuccessfulStates(this.loginModel);
}


class ShopLoginErrorStates extends ShopLoginStates
{
  final String error;
  ShopLoginErrorStates(this.error);
}

class ShopLoginSuffixChangeStates extends ShopLoginStates{}
