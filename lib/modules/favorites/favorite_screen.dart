import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/cubit/home_cubit.dart';
import 'package:shopapp/layouts/cubit/home_states.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context, state){},
      builder:(context, state)
      {
        var cubit = ShopHomeCubit.get(context);

        return ConditionalBuilder(
            condition:state is! ShopLoadingGetFavoritesState,
            fallback:(context)=> Center(child: CircularProgressIndicator()),
             builder:(context)=>ListView.separated(
             itemBuilder: (context, index) => buildListProduct(cubit.favoritesModel.data.data[index].product,context),
             separatorBuilder:(context, index) => myDivider(),
             itemCount:cubit.favoritesModel.data.data.length,
             ),
        );
      } ,
    );
  }

}
