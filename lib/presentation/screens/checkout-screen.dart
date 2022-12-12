import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business-logic/cubit-home-screen/home_cubit.dart';
import '../business-logic/cubit-home-screen/home_state.dart';

class CheckOutScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: ()async{
               // await HomeCubit.get(context).getLatitudeAndLongitude();
                print(HomeCubit.get(context).latitude) ;
                print(HomeCubit.get(context).longitude) ;
               // await HomeCubit.get(context).getLocation(HomeCubit.get(context).longitude,
               //      HomeCubit.get(context).latitude) ;

                print(HomeCubit.get(context).address) ;
              },
              child: Icon(
                Icons.add
              )
            ),
          ),
        );
      },
    );
  }
}
