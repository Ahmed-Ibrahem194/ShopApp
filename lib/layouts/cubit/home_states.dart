import 'package:shopapp/models/change_favorite_model.dart';
import 'package:shopapp/models/login_model.dart';

abstract class ShopHomeStates{}

class ShopHomeIntialState extends ShopHomeStates{}

class ShopHomeChangeButtomNavState extends ShopHomeStates{}

class ShopHomeLoadingState extends ShopHomeStates{}

class ShopHomeSuccessState extends ShopHomeStates{}

class ShopSuccessCategoriesState extends ShopHomeStates{}

class ShopSuccessFavoriteiesState extends ShopHomeStates
{
  final ChangeFavoriteModel model ;

  ShopSuccessFavoriteiesState(this.model);
}

class ShopChangeFavoriteiesState extends ShopHomeStates{}

class ShopSuccessGetFavoritesState extends ShopHomeStates{}

class ShopLoadingGetFavoritesState extends ShopHomeStates{}


class ShopSuccessGetProfileState extends ShopHomeStates
{
 final ShopLoginModel loginModel;

  ShopSuccessGetProfileState(this.loginModel);
}

class ShopLoadingGetProfileState extends ShopHomeStates{}

