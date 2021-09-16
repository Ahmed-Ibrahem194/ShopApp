import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/login/shop_login.dart';
import 'package:shopapp/modules/on_boarding/on_boarding.dart';
import 'package:shopapp/shared/styles/themes.dart';

import 'layouts/Shop_Layout.dart';
import 'layouts/cubit/home_cubit.dart';
import 'modules/login/cubit/cubit.dart';
import 'network/local/cach_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CashHelper.init();

  Widget widget;

  bool onBoarding = CashHelper.getData(key: "onBoarding");
  String token = CashHelper.getData(key: "token");

  if(onBoarding != null)
  {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLogin();
  }
      else {widget = OnBoardingScreen();
      }


  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  const MyApp({this.startWidget}) ;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
        create: (BuildContext context) =>ShopLoginCubit(),),
        BlocProvider(
          create:(BuildContext context) => ShopHomeCubit()..getHomeData()..getCategories()..getFavorites()..getUserData,
        ),
      ],
      child: MaterialApp(
        home:startWidget,
        //startWidget,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );

  }
}
