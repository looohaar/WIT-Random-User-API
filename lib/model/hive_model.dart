import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_user_api/model/model.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveModel extends HiveObject{
  @HiveField(0)
  final  Results results;
  HiveModel({required this.results});

}