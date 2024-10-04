import 'package:http/http.dart';
import 'dart:convert';

class NetworkData{
  NetworkData(this.url);
  final String url;
  Future getdata() async{
    Response response= await get(Uri.parse(url));
    if(response.statusCode==200)
    {
      String data=response.body;
      var decodedJson=jsonDecode(data);
      return decodedJson;
    }
    else
      {
        print(response.statusCode);
      }
  }
  }
