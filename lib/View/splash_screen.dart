import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_covid/View/world_states.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

 late final  AnimationController _controller=AnimationController(
     duration: const Duration(seconds: 3)
 ,vsync: this)..repeat();

 @override
 //disconnect screen
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//first wait 3 sec then move to next
  Timer(const Duration(seconds: 5),
      ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>WorldStatesScreen())));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            //image will be animated
       AnimatedBuilder(
           animation: _controller,
           child: Container(
             height: 200,
             width: 200,
            child:  const Center(
               child: Image(image: AssetImage('images/virus.png')),
             )
           ),
           builder: (BuildContext context,Widget? child){

       return Transform.rotate(
           angle: _controller.value * 2.0 * math.pi,
       child:child,);

       }),
            SizedBox(
              height: MediaQuery.of(context).size.height*.08,
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Covid-19\nTracker App',textAlign:TextAlign.center,style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 25
              ),),
            )
          ],
        ),
      ),
    );
  }
}
