import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:random_user_api/model/model.dart';
import 'package:random_user_api/services/user_services.dart';

class UserController extends GetxController{
  Rx<Mainmodel?>? userData= Mainmodel().obs;
  RxBool isLoading= true.obs;
  void getUserData() async{
    final userDataFetched= await UserServices().fetchData();
    if (userDataFetched!=null) {
      userData?.value= userDataFetched as Mainmodel?;
      isLoading.value=false;
      
    } else {
      return null;
      
    }
  } 
  @override
  void onInit(){
    getUserData();
    super.onInit();
  }

}