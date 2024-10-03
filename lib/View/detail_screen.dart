import 'package:flutter/material.dart';
import 'package:flutter_covid/View/world_states.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;

   int totalCases,todayDeaths,totalRecovered,active,critical,todayRecovered,tests;

   DetailScreen({
     required this.image,
     required this.name,
     required this.totalCases,
     required this.todayDeaths,
     required this.totalRecovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.tests,




   }) ;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.06),
                      ReuseableRow(title: 'Cases',value: widget.totalCases.toString(),),
                      ReuseableRow(title: 'Recovered',value: widget.totalRecovered.toString(),),
                      ReuseableRow(title: 'Deaths',value: widget.todayDeaths.toString(),),
                      ReuseableRow(title: 'Critical',value: widget.critical.toString(),),
                      ReuseableRow(title: 'Today Recovered',value: widget.totalRecovered.toString(),),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],

          )
        ],
      ),
    );
  }
}
