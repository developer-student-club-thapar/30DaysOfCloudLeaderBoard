import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final String name;
  final String email;
  final String qwiklabsProfile;
  final int total;
  final int track1Points;
  final int track2Points;

  User(this.name, this.email, this.qwiklabsProfile, this.total,
      this.track1Points, this.track2Points);
}

class UserData {
  List<User> _users = [];

  Future<void> addUser(String email, String name, String qwikLabId) async {
    final url = Uri.parse('https://gcloud.servatom.com/add');
    try{
    final response = await http.post(url,
        body: jsonEncode({
          "name": "$name",
          "email": "$email",
          "qwiklabs": "$qwikLabId",
        }));
    if(response.statusCode!=200){
      throw "Could Not Add User";
    }
    }catch(e){
      rethrow;
    }
  }

  Future<void> getUserList()async{
    final url = Uri.parse('https://gcloud.servatom.com/');
    try{
      final response = await http.get(url);
      if(response.statusCode==200){
        final responseData = json.decode(response.body) as List<dynamic>;
      
      responseData.forEach((element) { 
        _users.add(
          User(
            element["name"], 
            element["email"], 
            element["qwiklabURL"], 
            element["total_score"], 
            element["track1_score"], 
            element["track2_score"]),
        );
      });
      print(_users);
      }else{
        throw "Could Not Get data";
      }
      
    }catch(e){
      rethrow;
    }
  }
}
