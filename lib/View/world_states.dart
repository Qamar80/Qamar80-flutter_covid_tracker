import 'package:flutter/material.dart';
import 'package:flutter_covid/Model/WorldStatesModel.dart';
import 'package:flutter_covid/Services/states_services.dart';
import 'package:flutter_covid/View/countries_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>with TickerProviderStateMixin {


//help in pichart
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

  final colerList=<Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];


  @override
  Widget build(BuildContext context) {

    StatesServices statesServices=StatesServices();





    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*.01,),

               FutureBuilder(
                   future: statesServices.fetchWorldStatesRecords()
               ,builder: (context,AsyncSnapshot <WorldStatesModel>snapshot){
                     //if we have no data then shoe white screen
                 if(!snapshot.hasData){
                   return Expanded(
                     flex: 1,
                       child: SpinKitFadingCircle(
                     color: Colors.white,
                         size: 50.0,
                         controller: _controller,
                   ));
                 }
                 //if we have data so according to the data pi chart is show cases, recovered and deaths
                 else{
                   return Column(
                     children: [
                       PieChart(
                         dataMap: {
                           'Total':double.parse(snapshot.data!.cases!.toString()),
                           'Recovered':double.parse(snapshot.data!.recovered!.toString()),
                           'Death':double.parse(snapshot.data!.deaths!.toString()),
                         },
                         // data in perscentage
                         chartValuesOptions: const ChartValuesOptions(
                           showChartValuesInPercentage: true
                         ),
                         //define radius and position
                         chartRadius: MediaQuery.of(context).size.width/3.5,
                         legendOptions: const LegendOptions(
                             legendPosition: LegendPosition.left
                         ),

                         //define color and duration and shape
                         animationDuration: Duration(microseconds: 1200),
                         chartType: ChartType.ring,
                         colorList: colerList,
                       ),
                          // show data in screen
                       Padding(
                         padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                         child: Card(
                           child: Column(
                             children: [
                               ReuseableRow(title: 'Total',value: snapshot.data!.cases.toString(),),
                               ReuseableRow(title: 'Deaths',value: snapshot.data!.deaths.toString(),),
                               ReuseableRow(title: 'Recovered',value: snapshot.data!.recovered.toString(),),
                               ReuseableRow(title: 'Active',value: snapshot.data!.active.toString(),),
                               ReuseableRow(title: 'Critical',value: snapshot.data!.critical.toString(),),
                               ReuseableRow(title: 'Today Death',value: snapshot.data!.todayDeaths.toString(),),
                               ReuseableRow(title: 'Today Recovered',value: snapshot.data!.todayRecovered.toString(),),

                             ],
                           ),
                         ),
                       ),

                       //click on button and move to next screen
                       GestureDetector(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesListScreen()  ));
                         },
                         child: Container(
                           height: 50,
                           decoration:  BoxDecoration(
                               color: Color(0xff1aa260),
                               borderRadius: BorderRadius.circular(10)
                           ),
                           child: const Center(
                             child: Text('Track Countries'),
                           ),
                         ),
                       )
                     ],
                   );
                 }

               }),



            ],
          ),
        ),
      ),
    );
  }
}



class ReuseableRow extends StatelessWidget {
  String title,value;
   ReuseableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10,right: 10,top: 10,bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          SizedBox(
            height: 5,),
          Divider()
        ],
      ),
    );
  }
}
