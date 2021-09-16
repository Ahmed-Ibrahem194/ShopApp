class ChangeFavoriteModel
{
  bool status;
  String message;

  ChangeFavoriteModel.fromJason(Map<String, dynamic> jason)
  {
    status = jason["status"];
    message= jason["message"];
  }
}