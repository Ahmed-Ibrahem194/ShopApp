
class ShopLoginModel
{
  bool status;
  String message;

  UserData data;

  ShopLoginModel.fromJason(Map <String , dynamic> jason)     //named constractor
  {
    status = jason ["status"];
    message = jason ["message"];
    data = jason ["data"] != null ? UserData.fromJason(jason["data"]): null;
  }

}

class UserData
{
 int id;
 String name;
 String phone;
 String email;
 String image;
 String token;
 int credit;
 int point;

 UserData.fromJason(Map <String , dynamic> jason)     //named constractor
 {
    id = jason ["id"];
    name = jason ["name"];
    phone = jason ["phone"];
    email = jason ["email"];
    image = jason ["image"];
    token = jason ["token"];
    credit = jason ["credit"];
    point = jason ["point"];

 }
}
