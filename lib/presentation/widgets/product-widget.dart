

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/model/product-model.dart';

Widget GetAllProduct(ProductModel model) {

  return Container(
    width: 250,
    height: 250,
     padding: const EdgeInsets.all(8),
    decoration:BoxDecoration(
      borderRadius: BorderRadius.circular(15) ,
      color: Colors.grey[300],
    ) ,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Category Name' ,
          style: TextStyle(
            color: Colors.black ,
            fontSize: 20
          ),
        )  ,
        SizedBox(
            height: 15)  ,
        Text(
          '${model.title}' ,
          style: TextStyle(
              color: Colors.black ,
              fontSize: 24 ,
          ),
          overflow: TextOverflow.ellipsis,
        )  ,

        SizedBox(
            height: 25)  ,
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            color: Colors.white.withOpacity(0),
            height: 282,
            width: 272,
            child: Image(
              image: NetworkImage(
                '${model.image}'  ,
              ),
              fit:BoxFit.cover ,
              height: 280,
              width: 270,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ) ,
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6)  ,
            ),
            padding: EdgeInsets.all(8),
            child: Text(
              '''${model.price} \$''',
              style: TextStyle(
                color: Colors.black ,
                fontSize: 30 ,
              ),
            ),
          ),
        ),
      ],
    ),
  ) ;
}


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 0.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.black,
  ),
);



//defaultButton
Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      color: color,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          '${text.toUpperCase()}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );