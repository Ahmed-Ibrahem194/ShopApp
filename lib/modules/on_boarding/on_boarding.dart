

import 'package:flutter/material.dart';
import 'package:shopapp/layouts/Shop_Layout.dart';
import 'package:shopapp/modules/login/shop_login.dart';
import 'package:shopapp/network/local/cach_helper.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
   final String image;
   final String title;
   final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget
{

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller = PageController();
  bool isLast = false ;

  List<BoardingModel> boarding =
  [
    BoardingModel(image:'images/Boarding11.png',
                   title: "title 1",
                     body: "body 1"),
    BoardingModel(
        image:'images/Boarding22.png',
        title: "title 2",
        body: "body 2"),
    BoardingModel(image:'images/Boarding33.png',
        title: "title 3",
        body: "body 3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      actions: [
        TextButton(
          onPressed: ()
          {
            CashHelper.saveData(key: "onBoarding", value: true).then((value)
            {
              if(value)
              {
                navigateAndFinish(context,ShopLayout(),);
              }
            });
          },
          child: Text("Skip",),)
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children:
        [
          Expanded(
            child: PageView.builder
              (
                itemBuilder: (context,index)=> buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardcontroller,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index)
              {
                if(index == boarding.length - 1)
                {
                  setState(() {
                    isLast = true;
                  });
                }
                else
                  {
                    setState(() {
                      isLast = false;
                    });
                  }
              },
              ),
          ),
          SizedBox(height: 40.0,),
          Row(
            children:
            [
              SmoothPageIndicator(
                  controller: boardcontroller,
                  count: boarding.length,
                effect: ExpandingDotsEffect
                  (
                  spacing: 5.0,
                  dotHeight: 10.0,
                  dotWidth: 5.0,
                  dotColor: Colors.grey,
                  activeDotColor: defultColor,
                  expansionFactor: 4.0,

                ),
              ),
              Spacer(),

              FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast == true)
                  {
                  CashHelper.saveData(key: "onBoarding", value: true).then((value)
                  {
                  if(value)
                  {
                    navigateAndFinish(context,ShopLayout(),);
                  }
                  });
                  }

                    else
                      {
                        boardcontroller.nextPage(
                        duration: Duration(
                        milliseconds: 750,),
                        curve: Curves.fastLinearToSlowEaseIn,
                        );
                        }
                     },
              child: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),

        ],
      ),
    ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image:AssetImage('${model.image}') ,
        ),
      ),
      Text("${model.title}",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 15.0,),
      Text("${model.body}",
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 15.0,),


    ],
  );
}




