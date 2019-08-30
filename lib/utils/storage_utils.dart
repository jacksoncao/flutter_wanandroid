import 'package:path_provider/path_provider.dart';
import 'dart:io';

class StorageUtils{

  //Cookie的存储路径
  static Future<String> getCookieFilePath() async{
    Directory directory = await getTemporaryDirectory();
    return directory.path + "/cookie";
  }

}