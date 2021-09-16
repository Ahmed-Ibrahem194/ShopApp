
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/network/end_point.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginModel loginModel ;

  bool iisPassword = true;
  IconData mySuffix = Icons.visibility;

  ShopLoginCubit() :super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

 void userLogin({
   @required String email ,
   @required String password ,
 })
 {
  emit(ShopLoginLoadingStates());

   DioHelper.postData(
       url: LOGIN,
       data: {
               "email": email  ,
               "password": password ,
               }).then((value)
               {
                 loginModel= ShopLoginModel.fromJason(value.data);
                 emit(ShopLoginSuccessfulStates(loginModel));
               });
              }

  void suffixChange()
 {
   iisPassword =! iisPassword ;
   if(iisPassword){mySuffix =Icons.visibility; }
   else mySuffix = Icons.visibility_off;

 emit(ShopLoginSuffixChangeStates());
 }
}


