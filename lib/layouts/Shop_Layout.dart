
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/search/search_screen.dart';
import 'package:shopapp/shared/componant/componant.dart';

import 'cubit/home_cubit.dart';
import 'cubit/home_states.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
     listener: (context, state){},
      builder:(context, state)
      {
        var cubit = ShopHomeCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text("Salla"),
            actions:
            [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context,SearchScreen(),);
                  },
                  icon: Icon(Icons.search,),),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeButtom(index);
            },
            items:
            [
              BottomNavigationBarItem(
                icon:Icon(Icons.home,),
              label: "Home"),
              BottomNavigationBarItem(
                  icon:Icon(Icons.apps,),
                  label: "Categories"),
              BottomNavigationBarItem(
                  icon:Icon(Icons.favorite,),
                  label: "Favorites"),
              BottomNavigationBarItem(
                  icon:Icon(Icons.settings,),
                  label: "Settings"),
            ],
          ),
        );
      },
    );
  }
}
