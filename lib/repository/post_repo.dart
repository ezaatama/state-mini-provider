import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:state_provider/model/post.dart';

class PostRepo{
  Future<List<Data>> getData() async{
    List<Data> listData = [];
    try {
      var request = http.Request("GET", Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      http.StreamedResponse response = await request.send();

      if(response.statusCode == 200){
        var rawData = await response.stream.bytesToString();
        List<dynamic> data = json.decode(rawData);
        data.forEach((element) { 
         Data model =  Data.fromJson(element);
         listData.add(model);
        });
        return listData;
      }else{
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      print("Exception in Data $e");
      throw e;
    }
  }
}