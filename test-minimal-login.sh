#!/bin/bash

# Simple Login Test - Bypass Complex Build Issues
echo "🎯 Testing simple login functionality..."

cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect/mobile"

# Create a minimal test app
echo "1. Creating minimal test app..."
cat > lib/main_test.dart << 'EOF'
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HostelConnect Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

  Future<void> _testLogin() async {
    setState(() {
      _status = 'Testing login...';
    });

    try {
      // Test API connectivity
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/v1/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _status = '✅ Login successful!\nUser: ${data['user']['name']}\nRole: ${data['user']['role']}';
        });
      } else {
        setState(() {
          _status = '❌ Login failed: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _status = '❌ Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HostelConnect Login Test'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Test',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _testLogin,
              child: Text('Test Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _status,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
EOF

echo "2. Adding required imports..."
cat > lib/main_test_imports.dart << 'EOF'
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
EOF

echo "3. Testing the minimal app..."
flutter run -d emulator-5554 lib/main_test.dart

echo "✅ Minimal login test completed!"
