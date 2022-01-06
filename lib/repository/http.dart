import 'dart:convert';
import 'dart:io';

import 'package:state_provider/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:state_provider/utils/httpresponse.dart';

class ApiUrl{

  static Future<HTTPResponse<List<Datum>?>?> getUsers(int page) async {
    String url = "https://reqres.in/api/users?page=" + page.toString();

    try {
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var body = json.decode(response.body)['data'];
        List<Datum> userList = [];
        body.forEach((e){
          Datum user = Datum.fromJson(e);
          userList.add(user);
        });
        return HTTPResponse(
        true,
        userList,
        responseCode: response.statusCode
      );
      }else{
        return HTTPResponse(
        false,
        null,
        message: 'Invalid response received from Server!.',
        responseCode: response.statusCode
      );
      }
    } on SocketException {
      return HTTPResponse(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a minute or two.'
      );
    } on FormatException {
      return HTTPResponse(
        false,
        null,
        message: 'Invalid response received from server! Please try again in a minute or two.'
      );
    } catch(e){
      return HTTPResponse(
        false,
        null,
        message: 'Something went wrong! Please try again in a minute or two.'
      );
    }
  }

}

