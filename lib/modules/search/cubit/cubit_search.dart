import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/modules/search/cubit/states_search.dart';
import 'package:shopapp/network/end_point.dart';
import 'package:shopapp/network/remote/dio_helper.dart';
import 'package:shopapp/shared/componant/conestants.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
      token: token,
        url: SEARCH,
        data:{'texh' : text},
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);
      emit(SearchSucccessState());
    });
  }
}