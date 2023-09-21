import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import '../../shared/componant/componant.dart';
import '../register/register_screen.dart';
import 'Login_cubit/cubit.dart';
import 'Login_cubit/states.dart';

class LoginScreen extends StatelessWidget {

  var emailController=TextEditingController();
  var passController=TextEditingController();
  var formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,LoginStates>(
        listener: (BuildContext context, LoginStates state) { 
          if(state is LoginErrorState){
            messageToast(msg: state.error, state: ToastStates.ERROR);
          }
          if(state is LoginSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateFinish(context, SocialHomeLayout());
            });
          }
        },
        builder: (BuildContext context, LoginStates state) {
          return  Form(
            key: formKey,
            child:  Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextForm(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          labelText: "Email Address",
                          prefix: Icons.email,
                          validate: (value){
                            if(value.isEmpty){
                              return 'the email not allow to be empty';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          labelText: "Password",
                          prefix: Icons.lock,
                          validate: (value){
                            if(value.isEmpty){
                              return 'the password not allow to be empty';
                            }
                            return null;
                          },
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffix: SocialLoginCubit.get(context).suffix,
                          suffixPressed: (){
                            SocialLoginCubit.get(context).changePasswordIcons();
                          },
                          onSubmit: (value){
                            // دي علشان لما يضغط علي الصح يعمل للوجين
                            if(formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passController.text);
                            }
                          },

                        ),

                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context)=>defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text);
                              }
                            },
                            text: 'Login',
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Don\'t have an account ? '
                            ),
                            defaultTextButton(
                                function: (){
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: 'Register Now'
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
