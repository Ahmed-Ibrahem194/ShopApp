import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/cubit/home_cubit.dart';
import 'package:shopapp/layouts/cubit/home_states.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/shared/componant/componant.dart';

class CateogriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context, state){},
      builder:(context, state)
        {
          var cubit = ShopHomeCubit.get(context);
         return ListView.separated(
        itemBuilder: (context, index) => buildCatItem(cubit.categoriesModel.data.data[index],),
        separatorBuilder:(context, index) => myDivider(),
        itemCount: cubit.categoriesModel.data.data.length,
         );
        } ,
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
      [
        Image(
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
          image: NetworkImage(model.image),
        ),
        SizedBox(width: 20.0,),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios,),
      ],
    ),
  );
}
