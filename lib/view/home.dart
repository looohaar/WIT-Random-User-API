import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;
import 'package:random_user_api/model/model.dart';
import '../main.dart';
import '../services/user_services.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
// function for inserting data into the db
  Future putData(userDataList) async{
    await userVariable.clear();

    // insertig datas from the network into db
    for (var d in userDataList) {
      userVariable.add(d);
      
    }

  }
    List userDataList=[];
  var url="https://randomuser.me/api/";
  Future<bool?>? fetchData()async{
    try {
      var response= await http.get(Uri.parse(url));
      if (response.statusCode==200 || response.statusCode==201) {
      
        final decodedValue= json.decode(response.body);
        await putData(decodedValue);
       
        // return Mainmodel.fromJson(decodedValue);
        
      }
      //  else if(response.statusCode!=200 || response.statusCode!=201){
      //   Get.snackbar("Network Error", "Check your internet connection");

        
      // }
      else{
       
        return null;
      }
    } catch (e) {
      print(e.toString());
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

  
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random User Get',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold

        ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchData(),
          builder:(context,snapshot){
             if(snapshot.hasData) {
              if (userDataList.contains('empty')) {
                return const Text('No Data',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey
                ),
                );
                
              }else{
                ListView.builder(
                  itemBuilder: (context, index){
                   return ListTile(
                    leading: Text(
                      "${userDataList[index]["results"]["gender"]}"
                    
                    ),
                   );
                  });
              }
              
              
            }else {
              return const CircularProgressIndicator(
                color: Colors.deepPurple,
              );
                
              }
                return const SizedBox();
              

          } 
        
          
          ),
      ),
    );
  }
}
