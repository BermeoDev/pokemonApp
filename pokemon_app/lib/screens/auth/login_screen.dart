import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/providers/auth_provider.dart';
import 'package:pokemon_app/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await Provider.of<AuthProvider>(context, listen: false).login(_email, _password);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrarse: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Porfavor ingrese su email' : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Porfavor ingrese su contraseña' : null,
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: Text('Login'),
                onPressed: _submit,
              ),
              TextButton(
                child: const Text('Crear una cuenta'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}