import 'package:flutter/material.dart';
import 'package:myapp/services/ApiRequests.dart';
import 'package:myapp/services/models/Response.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:myapp/services/models/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myapp/services/UsersPreferences.dart';

//TODO: Add api key for all api requests
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class UserModel extends Model {
  Future<bool> signInWithGoogle() async {
    print("Here");
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    print("Here");
    if (googleSignInAccount == null) {
      return false;
    }
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    print("Here");
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    print("Here");
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    print("Here");
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    print("Here");
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    print('signInWithGoogle succeeded: $user');
    print("STUFF: ${user.uid}");
    print(
        "STUFF: ${user.displayName} ${user.email} ${user.isEmailVerified} ${user.phoneNumber} ${user.photoUrl}");

    try {
      var url = 'https://elon-server.herokuapp.com/users/googleLogin';

      Map data = {
        'email': user.email,
        'name': user.displayName,
        'photoUrl': user.photoUrl,
        'googleId': user.uid
      };
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      print("${response.statusCode}");
      print("${response.body}");

      dynamic bodyDecoded = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var jsonUser = bodyDecoded['user'];
        _currentUser = User.fromJson(jsonUser);
        UsersPreferences.setUsersUUID(_currentUser.uuid,
            isLoggedInWithGoogle: true);
        _isLoggedIn = true;

        notifyListeners();
        return true;
      } else {
        await googleSignIn.signOut();
        print("User Sign Out");
        print("HANDLE LOGIN RESPONSE ERROR!!!");
        if (bodyDecoded['errors'] != null) {
          List<dynamic> dynamicList = bodyDecoded['errors'] as List<dynamic>;
          _errors.addAll(dynamicList.cast<String>());
          notifyListeners();
          return false;
        } else {
          _errors.add('Could not talk to server. Please try again later');
          notifyListeners();
          return false;
        }
        //TODO: HANDLE RESPONSE ERROR
      }
    } catch (e) {
      //TODO: handle errors
      print('error logging in');
      print(e);
      _errors.add('Could not talk to server. Please try again later');
      notifyListeners();
      return false;
    }
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  User _currentUser;
  User get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    print("Sending in Login: $email $password");
    try {
      var url = 'https://elon-server.herokuapp.com/users/login';

      Map data = {
        'email': email,
        'password': password,
      };
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      print("${response.statusCode}");
      print("${response.body}");

      dynamic bodyDecoded = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var jsonUser = bodyDecoded['user'];
        _currentUser = User.fromJson(jsonUser);
        UsersPreferences.setUsersUUID(_currentUser.uuid);
        _isLoggedIn = true;

        notifyListeners();
        return true;
      } else {
        print("HANDLE LOGIN RESPONSE ERROR!!!");
        if (bodyDecoded['errors'] != null) {
          List<dynamic> dynamicList = bodyDecoded['errors'] as List<dynamic>;
          _errors.addAll(dynamicList.cast<String>());
          notifyListeners();
          return false;
        } else {
          _errors.add('Could not talk to server. Please try again later');
          notifyListeners();
          return false;
        }
        //TODO: HANDLE RESPONSE ERROR
      }
    } catch (e) {
      //TODO: handle errors
      print('error logging in');
      print(e);
      _errors.add('Could not talk to server. Please try again later');
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    UsersPreferences.setUsersUUID('');
    signOutGoogle();
    notifyListeners();
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkIfUserIsLoggedIn() async {
    _isLoggedIn = await UsersPreferences.isLoggedIn();
    if (_isLoggedIn) {
      notifyListeners();
    }
  }

  Future<bool> signUp(String email, String name, String password,
      String confirmPassword) async {
    print("Sending in SignUp: $email $password $confirmPassword");
    try {
      var url = 'https://elon-server.herokuapp.com/users/signUp';

      Map data = {
        'email': email,
        'name': name,
        'password': password,
        'confirmPassword': confirmPassword
      };
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      print("${response.statusCode}");
      print("${response.body}");

      dynamic bodyDecoded = jsonDecode(response.body);
      if (response.statusCode == 200 && bodyDecoded['success'] as bool) {
        var jsonUser = bodyDecoded['user'];
        _currentUser = User.fromJson(jsonUser);
        UsersPreferences.setUsersUUID(_currentUser.uuid);
        _isLoggedIn = true;
        notifyListeners();
        return true;
      } else {
        print("HANDLE SIGNUP RESPONSE ERROR!!!");

        if (bodyDecoded['errors'] != null) {
          List<dynamic> dynamicList = bodyDecoded['errors'] as List<dynamic>;
          _errors.addAll(dynamicList.cast<String>());
          notifyListeners();
          return false;
        } else {
          _errors.add('Could not talk to server. Please try again later');
          notifyListeners();
          return false;
        }
        //TODO: HANDLE RESPONSE ERROR
      }
    } catch (e) {
      //TODO: handle errors
      print('error signing up');
      print(e);
      _errors.add('Could not talk to server. Please try again later');
      notifyListeners();
      return false;
    }
  }

  // String _errorMessage = '';
  // String get errorMessage => _errorMessage;

  List<String> _errors = [];
  List<String> get errors => _errors;

  void cleanUpErrors() {
    // _errorMessage = '';
    _errors = [];
  }

  static UserModel of(BuildContext context, {bool rebuildOnChange = false}) =>
      ScopedModel.of(context, rebuildOnChange: rebuildOnChange);
}
