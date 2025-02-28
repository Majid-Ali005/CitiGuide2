import 'package:citi_guide/screens/Admin/admin_dashboard.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final _formKey = GlobalKey<FormState>();

  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _adminEmail = "AdminMajid@gmail.com";
  final String _adminPassword = "Majid1234";

  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      
      if (email == _adminEmail && password == _adminPassword) {
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      } else {
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid email or password")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!value.contains("@") || !value.endsWith(".com")) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: _login,
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

