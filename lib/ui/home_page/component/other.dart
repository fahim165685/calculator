import 'package:calculator/ui/home_page/component/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Other extends StatefulWidget {
  const Other({Key? key}) : super(key: key);

  @override
  State<Other> createState() => _OtherState();
}

class _OtherState extends State<Other> {
  String userInput='';
  String calculateAns ='';
  final List<String> buttons=[
    'C','DEL','%','/',
    '9','8','7','X',
    '6','5','4','-',
    '3','2','1','+',
    '0','00','.','='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                child:Container(
                  color: Colors.red,
                  alignment: Alignment.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:  [
                      Text(calculateAns,style:const TextStyle(fontSize: 40,color: Colors.blueAccent)),
                      Text(userInput,style:const TextStyle(fontSize: 25,color: Colors.black26)),
                    ],
                  ),
                ),
            ),
            Expanded(
              flex: 3,
                child: Container(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: buttons.length,
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                      itemBuilder: (context, index) {
                        if(index==0){
                          return  Button(
                              color: Colors.green,
                              text: buttons[index],
                              textColor:isOperator(buttons[index])?
                              Colors.black:
                              Colors.white,
                              press: (){
                                setState(() {
                                  userInput='';
                                  calculateAns='';
                                });
                              }
                          );
                        } else if(index == 1){
                          return  Button(
                              color: Colors.red,
                              text: buttons[index],
                              textColor:isOperator(buttons[index])?
                              Colors.black:
                              Colors.white,
                              press: (){
                                setState(() {
                                  userInput=userInput.substring(0,userInput.length-1);
                                });
                              }

                          );
                        }else if(index == buttons.length-1){
                          return  Button(
                              color: Colors.deepPurple,
                              text: buttons[index],
                              textColor:isOperator(buttons[index])?
                              Colors.black:
                              Colors.white,
                              press: (){
                                setState(() {
                                  equalPressed();
                                });
                              }

                          );
                        }
                        else{
                          return  Button(
                              color: Colors.deepPurple,
                              text: buttons[index],
                              textColor:isOperator(buttons[index])?
                              Colors.black:
                              Colors.white,
                              press: (){
                                setState(() {
                                  userInput=userInput+buttons[index];
                                });
                              }

                          );
                        }
                      },
                  ),
                )),
          ],
        ),
      ),
    );
  }
  bool isOperator(String x){
    if (x=='%'||x=='/'|| x=='X'||x=='-'||x=='+'||x=='-'||x=='='){
      return true;
    }
    return false;
  }
  void equalPressed(){
    String finalQuestion = userInput;
    finalQuestion = finalQuestion.replaceAll('X', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    calculateAns = eval.toStringAsFixed(eval.truncateToDouble()==eval? 0:2).toString();
  }
}
