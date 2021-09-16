
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/cubit/home_cubit.dart';
import 'package:shopapp/layouts/cubit/home_states.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
       listener:(context, state)
       {
         if(state is ShopSuccessFavoriteiesState )
           {
            if(!state.model.status)
              {
                showToast(msg:state.model.message , state: ToastStates.ERROR,);
              }
           }
       },
        builder:(context, state)
        {
          var cubit = ShopHomeCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.homeModel != null && cubit.categoriesModel != null,
              fallback:(context)=> Center(child: CircularProgressIndicator()),
              builder:(context)=> productsBuilder(cubit.homeModel,cubit.categoriesModel,context),
          );
        },
    );
  }

  Widget productsBuilder(HomeModel model , CategoriesModel categoriesModel , context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
          items:model.data.banners.map((e) =>  Image(
            width: double.infinity,
            fit: BoxFit.cover,
            image:NetworkImage("${e.image}"),
          ),).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayAnimationDuration:Duration(seconds: 1),
            autoPlayInterval: Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 10.0,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categoriess",
                style:TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10.0,),
              Container(
                height: 100.0,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) => buildCategoryItem(categoriesModel.data.data[index]) ,
                    separatorBuilder: (context,index) => SizedBox(width : 10.0,),
                    itemCount: categoriesModel.data.data.length,
                ),
              ),
              SizedBox(
                height: 20.0,),
              Text(
                "New Products",
                style:TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,),

        Container(
          color: Colors.grey[300],
          child: GridView.count(
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.699,
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                     model.data.products.length,
                    (index) =>buildGridProducts(model.data.products[index],context),
              ),
          ),
        ),
      ],
    ),
  );

  Widget buildGridProducts(ProductModel model , context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image),
            height: 200.0,
            width: double.infinity,
       ),
            if(model.discount != 0)
            Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                child: Text("DISCOUNT",
                style: TextStyle(
                  fontSize: 8.0,
                  color: Colors.white,
                ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                  "${model.name}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Row(
                children: [
                  Text(
                    "${model.price.round()}",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defultColor,
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  if(model.discount != 0)
                  Text(
                    "${model.oldprice.round()}",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: ()
                      {
                        ShopHomeCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.grey,
                        //ShopHomeCubit.get(context).favorites[model.id] ?defultColor : Colors.grey,
                        radius: 15.0,
                          child: Icon(
                              Icons.favorite_border,
                            color:Colors.white,
                            size: 12.0,
                          ),
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );



  Widget buildCategoryItem(DataModel model) => Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children:
  [
  Image(
  image:NetworkImage(model.image),
  fit: BoxFit.cover,
  height: 100.0,
  width: 100,
  ),
  Container(
  width:100.0,
  color: Colors.black.withOpacity(.8),
  child: Text(
  model.name,
  textAlign: TextAlign.center,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(
  color: Colors.white,
  ),
  ),
  ),
  ],
  );
}
