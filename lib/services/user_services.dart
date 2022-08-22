import 'dart:convert';

import 'package:get/get.dart';
import 'package:random_user_api/main.dart';
import 'package:random_user_api/model/model.dart';
import 'package:http/http.dart'as http;
class UserServices{
  List userDataList=[];
  var url="https://randomuser.me/api/";
  Future<bool?> fetchData()async{
    try {
      var response= await http.get(Uri.parse(url));
      if (response.statusCode==200 || response.statusCode==201) {
        final decodedValue= json.decode(response.body);
        await putData(decodedValue);
        // return Mainmodel.fromJson(decodedValue);
        
      } else if(response.statusCode!=200 || response.statusCode!=201){
        Get.snackbar("Network Error", "Check your internet connection");

        
      }else{
        return null;
      }
    } catch (SocketException) {
      print("No Internet"); 
      
    }
    // getting data from db
    var myMap= userVariable.toMap().values.toList();
    if (myMap.isEmpty) {
      userDataList.add('empty');
      
    } else {
      userDataList=myMap;
      
    }
    return Future.value(true);
  }




// function for inserting data into the db
  Future putData(userDataList) async{
    await userVariable.clear();

    // insertig datas from the network into db
    for (var d in userDataList) {
      userVariable.add(d);
      
    }

  }
}
