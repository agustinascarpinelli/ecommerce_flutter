import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCkO_j1oJcR5ZPzGHPnGFw3-kfz_WqSid0';
  final storage = const FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    //data que tengo que mandar en el body de la peticion
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken':true
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(response.body);

    if (decodeResp.containsKey('idToken')) {
      storage.write(key: 'token', value: decodeResp['idToken']);
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future<String?> loginUser(String email, String password) async {
    //data que tengo que mandar en el body de la peticion
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken':true
    };

    final url = Uri.https(
        _baseUrl, 'v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(response.body);

    if (decodeResp.containsKey('idToken')) {
      storage.write(key: 'token', value: decodeResp['idToken']);
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return null;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
