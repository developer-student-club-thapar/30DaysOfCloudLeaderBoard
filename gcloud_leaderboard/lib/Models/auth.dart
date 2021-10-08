import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  bool get isAuth {
    return _token != null;
  }
  Future<void> login(String username, String password) async {
    final url = Uri.parse('https://gcloud.servatom.com/login');
    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"username": "$username", "password": "$password"}));
      if (response.statusCode == 200) {
        _token = jsonDecode(response.body)["access_token"];
        print(_token);
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userData', _token!);
      } else {
        throw "could not login";
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void logout() async {
    _token = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    _token = prefs.getString('userData');

    notifyListeners();

    return true;
  }
}
