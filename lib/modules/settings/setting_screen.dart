import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/cubit/home_cubit.dart';
import 'package:shopapp/layouts/cubit/home_states.dart';
import 'package:shopapp/network/local/cach_helper.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/componant/conestants.dart';

class SettingsScreen extends StatelessWidget
{
  var nameController = TextEditingController() ;
  var emailController = TextEditingController() ;
  var phoneController = TextEditingController() ;


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
        listener: (context, state)
        {
        },
    builder:(context, state)
    {
      var model = ShopHomeCubit.get(context).userModel;
      nameController.text = model.data.name;
      nameController.text = model.data.email;
      nameController.text = model.data.phone;

      return ConditionalBuilder(
       condition: ShopHomeCubit.get(context).userModel != null ,
       fallback:(context)=> Center(child: CircularProgressIndicator()) ,
       builder:(context)=> Padding(
         padding: const EdgeInsets.all(20.0),
         child: Column(
           children:
           [
             defultFormField(
                 controller: nameController,
                 type: TextInputType.name,
                 validate: (String value)
                 {
                   if(value.isEmpty)
                   {
                     return 'Name must not be empty' ;
                   }
                 },
                 labelText: 'Name',
                 prefix: Icons.person
             ),
             SizedBox(
               height: 15.0,
             ),
             defultFormField(
               controller: emailController,
               type: TextInputType.emailAddress,
               validate: (String value)
               {
                 if(value.isEmpty)
                 {
                   return 'email must not be empty' ;
                 }
               },
               labelText: 'Email',
               prefix: Icons.email,
             ),
             SizedBox(
               height: 15.0,
             ),
             defultFormField(
               controller: phoneController,
               type: TextInputType.number,
               validate: (String value)
               {
                 if(value.isEmpty)
                 {
                   return 'phone must not be empty' ;
                 }
               },
               labelText: 'Phone',
               prefix: Icons.phone,
             ),
              SizedBox(height: 20.0,),
             defaultButton(
                 function: (){signOut(context);},
                 text: 'LOGOUT',
             ),
           ],
         ),
       ),
     );
    }
    );
  }
}
