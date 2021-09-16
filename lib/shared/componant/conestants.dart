
import 'package:shopapp/modules/login/shop_login.dart';
import 'package:shopapp/network/local/cach_helper.dart';

import 'componant.dart';

  void signOut(context)
{
   CashHelper.removeData(key: "token",).then((value) {
     navigateAndFinish(context, ShopLogin(),);
  });
}

String token = "" ;