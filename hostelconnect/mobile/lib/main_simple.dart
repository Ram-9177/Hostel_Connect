import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HostelConnect Login Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: LoginTestPage(),
    );
  }
}

class LoginTestPage extends StatefulWidget {
  @override
  _LoginTestPageState createState() => _LoginTestPageState();
}

class _LoginTestPageState extends State<LoginTestPage> {
  final _emailController = TextEditingController(text: 'student@demo.com');
  final _passwordController = TextEditingController(text: 'password123');
  String _status = 'Ready to test login';
  bool _isLoading = false;

  Future<void> _testLogin() async {
    setState(() {
      _isLoading = true;
      _status = 'Testing login...';
    });

    try {
      // Test API connectivity
      final response = await http.post(
        Uri.parse('http://10.17.134.33:3000/api/v1/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _status = '✅ Login successful!\n\nUser: ${data['user']['name']}\nRole: ${data['user']['role']}\nEmail: ${data['user']['email']}\n\nAccess Token: ${data['accessToken'].substring(0, 20)}...';
        });
      } else {
        setState(() {
          _status = '❌ Login failed: ${response.statusCode}\n${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _status = '❌ Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HostelConnect Login Test'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.login,
              size: 64,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Login Test',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _testLogin,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Test Login',
                        style: TextStyle(fontSize: 18),
                      ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade50,
              ),
              child: Text(
                _status,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'API Server: http://10.17.134.33:3000',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
