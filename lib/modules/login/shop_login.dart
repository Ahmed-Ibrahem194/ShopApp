import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layouts/Shop_Layout.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/modules/register_screen/register_screen.dart';
import 'package:shopapp/network/local/cach_helper.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/componant/conestants.dart';

import 'cubit/cubit.dart';

class ShopLogin extends StatelessWidget {

  var formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<ShopLoginCubit,ShopLoginStates>(
    listener: (context , state)
    {
      if(state is ShopLoginSuccessfulStates)
        {
          if(state.loginModel.status)
            {
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,          //مدة الظهور
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.black38,
                  textColor: Colors.white,
                  fontSize: 16.0 ,
              );
              CashHelper.saveData(key: "token", value:state.loginModel.data.token,).then((value)
              {
                token = state.loginModel.data.token;
                navigateAndFinish(context,ShopLayout(),);
              });

            }else
              {
                 showToast(
                     msg: state.loginModel.message,
                     state:ToastStates.ERROR ,);
              }
        }

    },
    builder: (context , state) => Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text("LOGIN",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Login now to browse our hot offers",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (value)
                    {
                      if (value.isEmpty)
                      {
                        return "Enter your email";
                      }

                    },
                    labelText: "Email Adress",
                    prefix: Icons.email_outlined,),

                  SizedBox(
                    height: 20.0,
                  ),

                  defultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (value)
                      {
                         if (value.isEmpty)
                         {
                          return "Enter your password";
                         }

                      },
                      labelText:  "Password",
                      prefix: Icons.lock_open_outlined,
                      suffix: ShopLoginCubit.get(context).mySuffix,
                      isPassword: ShopLoginCubit.get(context).iisPassword,
                      suffixPressud:()
                        {
                         ShopLoginCubit.get(context).suffixChange();
                        } ,
                    ),


                  SizedBox(
                    height: 20.0,
                  ),
                  ConditionalBuilder(
                    condition:state is! ShopLoginLoadingStates ,
                    builder:(context) =>  Container(
                      width: double.infinity,
                      color: Colors.blue,
                      child: MaterialButton(
                        onPressed: ()
                        {
                          if(formkey.currentState.validate())
                           {
                              ShopLoginCubit.get(context).userLogin
                              (email: emailController.text, password: passwordController.text);
                           }
                        },
                        child: Text("LOGIN",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    fallback:(context)=> Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      Text("Dont have an account?",),
                      TextButton(
                        onPressed: ()
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text("Register now",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
      );
  }
}