import 'package:flutter/material.dart';
import 'package:flutter_covid/Services/states_services.dart';
import 'package:flutter_covid/View/detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
} 

class _CountriesListScreenState extends State<CountriesListScreen> {


// it is for searching
  TextEditingController searchControler =TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
         body: SafeArea(
           child: Column(
             children: [
               Padding(
                 //it is for searching
                 padding: const EdgeInsets.all(8.0),
                 child: TextFormField(
                   controller: searchControler,
                   onChanged: (value){
                     setState(() {

                     });
                   },
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(horizontal: 20),
                     hintText: 'search with country name',
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(50.0)
                     )
                   ),
                 ),
               ),

               Expanded(
                   child: FutureBuilder(
                     future: statesServices.countriesListApi()
                       ,builder: (context,AsyncSnapshot<List<dynamic>>snapshot){

                     if(!snapshot.hasData){
                       return ListView.builder(
                           itemCount:  6
                           ,itemBuilder: (context,index){
                             return Shimmer.fromColors(
                                 baseColor: Colors.grey.shade700,
                                 highlightColor: Colors.grey.shade100,
                               child:  Column(
                             children: [
                             ListTile(
                             title:Container(height: 10,width: 10,color: Colors.white,),
                         subtitle:  Container(height: 10,width: 10,color: Colors.white,),
                         leading: Container(height: 10,width: 10,color: Colors.white,),
                         )
                         ],
                         ),
                             );
                       });
                     }else{
                       return ListView.builder(
                         itemCount:  snapshot.data!.length
                       ,itemBuilder: (context,index){
                           String name= snapshot.data![index]['country'];
                           if(searchControler.text.isEmpty) {
                             return Column(
                               children: [
                                 InkWell(
                               onTap: (){
                                 Navigator.push(context,
                                     MaterialPageRoute(builder: (context)=>DetailScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                       name:snapshot.data![index]['country'],
                                       totalCases:snapshot.data![index]['cases'],
                                       totalRecovered:snapshot.data![index]['recovered'],
                                       todayDeaths:snapshot.data![index]['todayDeaths'],
                                       active:snapshot.data![index]['active'],
                                       tests:snapshot.data![index]['tests'],
                                       todayRecovered:snapshot.data![index]['todayRecovered'],
                                       critical:snapshot.data![index]['critical'],
                                     )));
                               },
                                   child: ListTile(
                                     title:Text( snapshot.data![index]['country']),
                                     subtitle:  Text(snapshot.data![index]['cases'].toString())
                                     ,leading: Image(
                                       height: 50,
                                       width: 50
                                       ,image: NetworkImage(
                                       snapshot.data![index]['countryInfo']['flag']
                                   )),
                                   ),
                                 )
                               ],
                             );
                             }else if(name.toLowerCase().contains(searchControler.text.toLowerCase())){
                             return Column(
                               children: [
                                 InkWell(
                               onTap: (){
                                 Navigator.push(context,
                                     MaterialPageRoute(builder: (context)=>DetailScreen(
                                       image: snapshot.data![index]['countryInfo']['flag'],
                                       name:snapshot.data![index]['country'],
                                       totalCases:snapshot.data![index]['cases'],
                                       totalRecovered:snapshot.data![index]['recovered'],
                                       todayDeaths:snapshot.data![index]['todayDeaths'],
                                       active:snapshot.data![index]['active'],
                                       tests:snapshot.data![index]['tests'],
                                       todayRecovered:snapshot.data![index]['todayRecovered'],
                                       critical:snapshot.data![index]['critical'],

                                     )));
                               },
                                   child: ListTile(
                                     title:Text( snapshot.data![index]['country']),
                                     subtitle:  Text(snapshot.data![index]['cases'].toString())
                                     ,leading: Image(
                                       height: 50,
                                       width: 50
                                       ,image: NetworkImage(
                                       snapshot.data![index]['countryInfo']['flag']
                                   )),
                                   ),
                                 )
                               ],
                             );
                           }else{
                             return Container();
                           }




                       });
                     }

                   })
               )
             ],
           ),
         ),

    );
  }
}
