import 'dart:convert';

import 'package:flutter_covid/Services/Utilities/app_url.dart';
import 'package:http/http.dart'as http;

import '../Model/WorldStatesModel.dart';

class StatesServices{

  // in this fun and class we call api and get data
  // and then show data in screen

  Future<WorldStatesModel> fetchWorldStatesRecords()async{

   final response=await http.get(Uri.parse(AppUrl.worldStatesApi));
   if(response.statusCode==200){
     var data=jsonDecode(response.body);
     return WorldStatesModel.fromJson(data);
   }else{
     throw Exception('Error');
  }
}


Future<List<dynamic>> countriesListApi()async{
  var data;
   final response=await http.get(Uri.parse(AppUrl.countriesList));
   if(response.statusCode==200){
     var data=jsonDecode(response.body);
     return data;
   }else{
     throw Exception('Error');
  }
}
}