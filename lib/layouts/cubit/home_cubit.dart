
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/cubit/home_states.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/change_favorite_model.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/modules/cateogries/cateogries_screen.dart';
import 'package:shopapp/modules/favorites/favorite_screen.dart';
import 'package:shopapp/modules/products/products_screen.dart';
import 'package:shopapp/modules/settings/setting_screen.dart';
import 'package:shopapp/network/end_point.dart';
import 'package:shopapp/network/remote/dio_helper.dart';
import 'package:shopapp/shared/componant/conestants.dart';

class ShopHomeCubit extends Cubit<ShopHomeStates>
{
  ShopHomeCubit() : super(ShopHomeIntialState());

  static ShopHomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  Map <int , bool> favorites = {};    // int for id of product   bool favorite or not

  List<Widget> bottomScreens =
  [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];


  void changeButtom(int index)
  {
    currentIndex = index;
    emit(ShopHomeChangeButtomNavState());
  }

  HomeModel homeModel;
  void getHomeData()
  {
    emit(ShopHomeLoadingState());

    DioHelper.getData(
      url: HOME,
      token:token,
    ).then((value)
    {
      homeModel = HomeModel.fromJason(value.data);

      homeModel.data.products.forEach((element)
      {
        favorites.addAll({
          element.id : element.inFavorite,
        });
      });
      print(favorites.toString());
      emit(ShopHomeSuccessState());
    });
  }

 CategoriesModel categoriesModel;
  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token:token,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJason(value.data);
      emit(ShopSuccessCategoriesState());
    });
  }


  ChangeFavoriteModel changeFavoriteModel;
  void changeFavorites(int productId)
  {
    favorites[productId] =! favorites[productId];
    emit(ShopChangeFavoriteiesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {"product_id": productId,},
      token: token,
        )
          .then((value)
           {
             changeFavoriteModel =ChangeFavoriteModel.fromJason(value.data);
             if(!changeFavoriteModel.status)
               {
                 favorites[productId] = !  favorites[productId];
               }else
                 {
                   getFavorites();
                 }
              emit(ShopSuccessFavoriteiesState(changeFavoriteModel));
           });
  }

      FavoritesModel favoritesModel;
     void getFavorites()
       {
         emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token:token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    });
  }



  ShopLoginModel userModel;
  void getUserData()
  {
    emit(ShopLoadingGetProfileState());
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJason(value.data);
      emit(ShopSuccessGetProfileState(userModel));
    });
  }
}