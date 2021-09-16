class CategoriesModel
{
  bool status;
  CategoriesDataModel data;

  CategoriesModel.fromJason(Map<String,dynamic> jason)
  {
    status = jason['status'];
    data = CategoriesDataModel.fromJason(jason['data']);
  }
}

class CategoriesDataModel
{
 int currentPage;
 List<DataModel> data = [];

 CategoriesDataModel.fromJason(Map<String,dynamic> jason)
 {
   currentPage = jason['current_page'];

   jason['data'].forEach((element)
   {
     data.add(DataModel.fromJason(element));
   });

 }
}

class DataModel
{
  int id;
  String name;
  String image;

  DataModel.fromJason(Map<String,dynamic> jason)
  {
    id = jason['id'];
    name = jason['name'];
    image = jason['image'];
  }
}