import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:random_user_api/model/hive_model.dart';
import 'package:random_user_api/view/home.dart';
late Box<HiveModel> userVariable;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());
  userVariable= await Hive.openBox<HiveModel>('hiveusermodel');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        
        primarySwatch: Colors.deepPurple
      ),
      home: const Home(),
    );
  }
}

