
class HomeModel
{
  bool status;
  HomeDataModel data;

  HomeModel.fromJason(Map<String,dynamic> jason)
  {
    status = jason["status"];
    data =  HomeDataModel.fromJason(jason["data"]);
  }
}

class HomeDataModel
{
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJason(Map<String,dynamic> jason)
  {
    jason["banners"].forEach((element)
    {
      banners.add(BannerModel.fromJason(element));
    }
    );

      jason["products"].forEach((element)
      {
        products.add(ProductModel.fromJason(element));
      }
      );
  }
}

class BannerModel
{
  int id;
  String image;
  BannerModel.fromJason(Map<String,dynamic> jason)
  {
    id = jason["id"];
    image= jason["image"];
  }

}

class ProductModel
{
  int id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String image;
  String name;
  bool inFavorite;
  bool inCart;

  ProductModel.fromJason(Map<String,dynamic> jason)
  {
    id = jason["id"];
    price= jason["price"];
    oldprice= jason["old_price"];
    discount= jason["discount"];
    image= jason["image"];
    name= jason["name"];
    inFavorite= jason["in_favorites"];
    inCart= jason["in_cart"];

  }

}