import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app.dart';
import 'package:social_app/modules/register/register_cubit/cubit.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';

import '../../shared/componant/componant.dart';


class ShopRegisterScreen extends StatelessWidget {


  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passController=TextEditingController();
  var phoneController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)  => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,RegisterStates>(
        listener: (context,state){
        if(state is SocialCreateUserSuccessState) {
            navigateFinish(context, SocialHomeLayout());
        }
        },
        builder: (context,state){
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                         SizedBox(
                          height: 30,
                        ),
                        defaultTextForm(
                          controller: nameController,
                          type: TextInputType.name,
                          labelText: "UserName",
                          prefix: Icons.person,
                          validate: (value){
                            if(value.isEmpty){
                              return 'the name not allow to be empty';
                            }
                            return null;
                          },
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
                              return 'password is too short';
                            }
                            return null;
                          },
                          isPassword: SocialRegisterCubit.get(context).isPassword,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: (){
                            SocialRegisterCubit.get(context).changePasswordIcons();
                          },
                          onSubmit: (value){
                            }
                        ),
                         SizedBox(
                          height: 30,
                        ),
                        defaultTextForm(
                          controller: phoneController,
                          type: TextInputType.phone,
                          labelText: "Phone",
                          prefix: Icons.phone,
                          validate: (value){
                            if(value.isEmpty){
                              return 'the phone not allow to be empty';
                            }
                            return null;
                          },
                        ),

                         SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context)=>defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passController.text,
                                    phone: phoneController.text
                                );
                              }},
                            text: 'Register',
                          ),
                          fallback:(context)=>  Center(child: CircularProgressIndicator()),
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
