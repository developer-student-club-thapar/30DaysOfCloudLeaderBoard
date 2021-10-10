// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final String email;
  final String qwiklabsProfile;
  final String profileImage;
  final int total;
  final int track1Points;
  final int track2Points;
  final int position;

  User(this.name, this.email, this.qwiklabsProfile, this.profileImage,
      this.total, this.track1Points, this.track2Points, this.position);
}

class UserData extends ChangeNotifier {
  List<User> _users = [];
  List<User> _searchList = [];
  Map<dynamic,int> chartMap = {};
  List<User> get users {
    return [..._users];
  }

  List<User> get searchList {
    return [..._searchList];
  }

  Map<dynamic,int> getMap(){
    chartMap = {};
    _users.forEach((element) { 
      if(chartMap.containsKey(element.total)){

      chartMap[element.total] = chartMap[element.total]! + 1;
      }else{
        chartMap[element.total] = 1;
      }
    });
    return chartMap;
  }

  Future<void> getUserList() async {
    int i = 1;
    _users = [];
    final url = Uri.parse('https://gcloud.servatom.com/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as List<dynamic>;

        responseData.forEach((element) {
         
          
          _users.add(
            User(
                element["name"],
                element["email"],
                element["qwikLabURL"],
                element["profile_image"],
                element["total_score"],
                element["track1_score"],
                element["track2_score"],
                i),
          );
          i++;
        });
        
        notifyListeners();
      } else {
        throw "Could Not Get data";
      }
    } catch (e) {
      rethrow;
    }
  }

  void search(String name) {
    _searchList = [];
    if (name == "") {
    } else {
      _users.forEach((element) {
        if (element.name.toLowerCase().contains(name)) {
          _searchList.add(element);
        }
      });
    }

    notifyListeners();
  }

  String get emptyListen {
    return 'ok';
  }

  void emptySearchList() {
    _searchList = [];
  }
}
