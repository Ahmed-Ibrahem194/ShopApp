

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/modules/register_screen/cubit_register/states.dart';
import 'package:shopapp/network/end_point.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

class ShopRegiterCubit extends Cubit<ShopRegisterStates>
{
  ShopLoginModel loginModel ;

  bool isPasswordd = true;
  IconData mySuffix = Icons.visibility;

  ShopRegiterCubit() :super(ShopRegiterInitialStates());

  static ShopRegiterCubit get(context) => BlocProvider.of(context);

  void userRegiter({
    @required String name ,
    @required String email ,
    @required String password ,
    @required String phone ,

  })
  {
    emit(ShopRegiterLoadingStates());

    DioHelper.postData(
        url: REGISTER,
        data: {
          "name": name  ,
          "email": email  ,
          "password": password ,
          "phone": phone  ,
        }).then((value)
    {
      loginModel= ShopLoginModel.fromJason(value.data);
      emit( ShopRegisterSuccessfulStates(loginModel));
    });
  }

  void suffixChange()
  {
    isPasswordd =! isPasswordd ;
    if(isPasswordd){mySuffix =Icons.visibility; }
    else mySuffix = Icons.visibility_off;
    emit(ShopRegisterSuffixChangeStates());
  }
}

