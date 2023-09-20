
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/shared_pref.dart';
import '../../shared/styles/colors.dart';
import 'login/shop_login.dart';

class BoardingModel {
  String? image;
  String? title;
  String? body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardScreen extends StatefulWidget {
  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var boardController = PageController();
  bool isLast = false;
  void submit()
  {
    CachHelper.saveData(value: true, key: 'OnBoarding').then((value) {
      if(value==true)
        {
          NavigateAndReplace(context, ShopLoginScreen());
        }
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onBoard_1.jpg',
        body:
            'There are more than 1.000 brands of men`s and women`s clothes and shoes in the catalog',
        title: 'Explore Many Products'),
    BoardingModel(
        image: 'assets/images/onBoard_2.jpg',
        body:
            'Just 2 clicks and you can buy all the fashions news with home delivery',
        title: 'Choose and checkout'),
    BoardingModel(
        image: 'assets/images/onBoard_3.jpg',
        body:
            'The order can be paid by credit card or cash at the time of delivery',
        title: 'Get it dellivered'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defualtTextButton(
            function: submit,
            text: 'Skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildboardingitem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: CustomizableEffect(
                    spacing: 5.0,
                    dotDecoration: DotDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey,
                      verticalOffset: 5.0,
                      rotationAngle: 50.0,
                      height: 10,
                      width: 10,
                    ),
                    activeDotDecoration: DotDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: defaultcolor,
                      width: 30,
                      height: 10,
                    ),
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                     submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          microseconds: 850,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildboardingitem(BoardingModel model) => Column(
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.title}',
          style: TextStyle(fontSize: 24.0),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(fontSize: 14.0),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
