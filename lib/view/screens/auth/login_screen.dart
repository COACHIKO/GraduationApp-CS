import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/api_controller.dart';

class LogInScreenPage extends StatefulWidget {
  LogInScreenPage({super.key});

  @override
  State<LogInScreenPage> createState() => _LogInScreenPageState();
}

class _LogInScreenPageState extends State<LogInScreenPage> {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final ApiController apiController = ApiController(); // Create an instance of ApiController

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFF1c1c1e),
        centerTitle: true,
        title: Text("Login"),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_sharp),
          color: Colors.blueAccent,
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Form(
            key: loginKey,
            child: Column(
              children: [
                Container(
                  child: Image(
                    height: 120.h,
                    image: AssetImage("assets/100.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                TextFormField(
                  controller: username,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 0) {
                      return "33".tr;
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.blueAccent),
                    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    fillColor: const Color(0xff1f1f1F),
                    filled: true,
                    label: Text("Username or Email"),
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 8.h,),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(80),
                  ],
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    } else if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                      return "Password must contain at least one letter";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.blueAccent),
                    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    fillColor: Color(0xff1f1f1F),
                    filled: true,
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 60.h),
                  child: Center(
                    child: MaterialButton(
                      color: const Color(0xff1f1f1F),
                      minWidth: 155,
                      height: 45.h,
                      splashColor: Colors.blueAccent,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      onPressed: () async {
                        if (loginKey.currentState!.validate()) {
                          loginKey.currentState!.save();
                          await apiController.login(username.text.toString(), password.text.toString());
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
