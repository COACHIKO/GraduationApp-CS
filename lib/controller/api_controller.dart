import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../linkapi.dart';
import '../main.dart'; // Adjust the import path based on your project structure
 import '../view/screens/auth/fork_usering_page.dart';
import '../view/screens/home_screen.dart';
import 'home_controller.dart';

class ApiController extends GetxController {
  HomeController homeController = Get.put(HomeController());

  //register Function
  Future<void> register(String email ,String lastname,password,username,firstname) async {
    const String registerUrl = AppLink.signUpApi;

    var response = await http.post(Uri.parse(registerUrl), body: {
      "Email": email,
      "LastName":lastname,
      "Password":password,
      "UserName":username,
      "FirstName":firstname,
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data != null && data['isAuthenticated'] == true) {
        // Registration successful

        // Use the user information and token as needed
        // For example, you might want to save the token for future API requests.

        Get.offAll(const forkUseringPage());
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: 'Registration Successful',
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          msg: data['message'] ?? 'Error occurred during registration',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else {
      // Handle server errors or other issues
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Server error: ${response.reasonPhrase}',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
  //login Function
  Future<void> login(String email, String pass) async {
    var url = Uri.parse(AppLink.logInApi);
    var response = await http.post(url, body: {
      "Email": email,
      "Password": pass,
    });

    var data = json.decode(response.body);

    if (data["isAuthenticated"] == true) {
      // Update shared preferences with user data
      myServices.sharedPreferences.setBool("isAuthenticated", true);
Get.offAll(const HomePage());
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Login Successful',
        toastLength: Toast.LENGTH_SHORT,
      );

      // Navigate to different pages based on user type
      // Show a welcome message using Fluttertoast
    } else {

      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Login Failed',
        toastLength: Toast.LENGTH_SHORT,
      );

      // Show an error message using Fluttertoast
    }
  }
  //Get Routine Data


}
