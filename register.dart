import 'package:flutter/material.dart';
import 'login.dart'; // นำเข้าสำหรับหน้า Login


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/Logo1.png', width: 250, height: 250),
                    const SizedBox(height: 20),
                  ],
                ),
                // Email field
                _buildEmailField(),
                const SizedBox(height: 16),
                // Username field
                _buildUsernameField(),
                const SizedBox(height: 16),
                // Password field
                _buildPasswordField(),
                const SizedBox(height: 24),
                _buildRegisterButton(context),
                const SizedBox(height: 16),
                _buildLoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method for email field
  SizedBox _buildEmailField() {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter an email';
          } else if (!RegExp(r'^[\w\.-]+@(hotmail|gmail|yahoo|outlook)\.com$').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }

  // Method for username field
  SizedBox _buildUsernameField() {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          labelText: 'Username',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a username';
          }
          return null;
        },
      ),
    );
  }

  // Method for password field
  SizedBox _buildPasswordField() {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
        obscureText: !_isPasswordVisible,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[\W_]).{6,}$').hasMatch(value)) {
            return '- Password must be at least 6 characters long \n- contain an uppercase letter and at least 1 \nspecial character.';
          }
          return null;
        },
      ),
    );
  }

  // Method for register button
  Center _buildRegisterButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // นำข้อมูล username และ password ไปที่หน้า LoginPage
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginPage(
                  registeredUsername: _usernameController.text,
                  registeredPassword: _passwordController.text,
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          backgroundColor: Colors.yellow,
        ),
        child: const Text('Register'),
      ),
    );
  }

  // Method for login link
  TextButton _buildLoginLink() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(registeredUsername: '', registeredPassword: ''),
          ),
        );
      },
      child: const Text(
        'Already have an account? >> Go to Login',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
