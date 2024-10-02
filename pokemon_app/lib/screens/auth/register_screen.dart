import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await Provider.of<AuthProvider>(context, listen: false).register(_username, _email, _password);
        Navigator.pop(context);
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
      appBar: AppBar(title: Text('Registrarse')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Usuario'),
                validator: (value) => value!.isEmpty ? 'Por favor ingrese su usuario' : null,
                onSaved: (value) => _username = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Por favor ingrese su email' : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Por favor ingrese su contraseña' : null,
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Registrar'),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



