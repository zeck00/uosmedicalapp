import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoginFailed = false; // New flag to track login failure

  void _login() async {
    // Convert both input username and hardcoded username to lowercase for comparison
    final username = _usernameController.text.toLowerCase();
    final password = _passwordController.text;

    // The hardcoded credentials are also converted to lowercase
    if (username == 'admin@uos'.toLowerCase() && password == 'admin@uos') {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        _isLoginFailed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.green,
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Splash.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: BlurryContainer(
              borderRadius: BorderRadius.circular(35),
              blur: 25,
              color: MyColors.white.withAlpha(100),
              child: Padding(
                padding: EdgeInsets.all(screenSize.width * 0.1),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: screenSize.height * 0.1),
                      Text("Login", style: FontStyles.categories),
                      SizedBox(height: screenSize.height * 0.05),
                      _buildTextField(_usernameController, "Email", false),
                      SizedBox(height: screenSize.height * 0.02),
                      _buildTextField(_passwordController, "Password", true),
                      SizedBox(height: screenSize.height * 0.01),
                      if (_isLoginFailed) ...[
                        Text(
                          "Not a registered user or wrong credentials",
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                      ],
                      TextButton(
                        onPressed: () {
                          // Placeholder for registration logic
                        },
                        child: Text(
                          "Register a new account",
                          style: TextStyle(color: MyColors.blue),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.03),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: MyColors.blue, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: _login,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: screenSize.width * 0.1,
                          ),
                          child: Text("Sign In", style: FontStyles.categories),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, bool obscureText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: FontStyles.subs,
        filled: true,
        fillColor: MyColors.white.withAlpha(100),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: obscureText,
      style: FontStyles.subs,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
