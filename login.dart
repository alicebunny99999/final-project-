import 'package:flutter/material.dart';
import 'home_screen.dart'; // นำเข้าสำหรับหน้า HomeScreen
import 'register.dart'; // นำเข้าสำหรับหน้า Register

class LoginPage extends StatefulWidget {
  final String registeredUsername; // รับ username ที่ลงทะเบียน
  final String registeredPassword; // รับ password ที่ลงทะเบียน

  const LoginPage({super.key, required this.registeredUsername, required this.registeredPassword});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isPasswordVisible = false; // ตัวแปรสำหรับ toggle visibility ของ password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: const Text('Login'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // ปุ่มลูกศรย้อนกลับ
          onPressed: () {
            // ย้อนกลับไปยังหน้า Register
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const RegisterPage(), // เปลี่ยนไปหน้า Register
              ),
            );
          },
        ),
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
                // Username field
                SizedBox(
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
                ),
                const SizedBox(height: 16),
                // Password field
                SizedBox(
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
                            _isPasswordVisible = !_isPasswordVisible; // เปลี่ยนสถานะการแสดงผล
                          });
                        },
                      ),
                    ),
                    obscureText: !_isPasswordVisible, // แสดงรหัสผ่านหาก _isPasswordVisible เป็น true
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // ตรวจสอบ username และ password กับข้อมูลที่ลงทะเบียน
                        if (_usernameController.text == widget.registeredUsername &&
                            _passwordController.text == widget.registeredPassword) {
                          // ถ้าตรงไปที่หน้า HomeScreen
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                        } else {
                          // แสดง SnackBar เมื่อข้อมูลไม่ตรง
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Invalid username or password',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      backgroundColor: Colors.yellow,
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 16),
                // Forgot Password link
                TextButton(
                  onPressed: () {
                    // เมื่อกดลิงก์ Forgot Password
                    _usernameController.clear(); // ล้างข้อมูลที่กรอก
                    _passwordController.clear(); // ล้างข้อมูลที่กรอก
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(), // นำไปยังหน้า Register
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
