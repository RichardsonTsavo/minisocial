import 'package:email_validator/email_validator.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/modules/register/register_store.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key? key, this.title = 'RegisterPage'}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final RegisterStore store = Modular.get();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criar conta")),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),

            child: FormBuilder(
              key: _formKey,

              child: Column(
                children: [
                  FormBuilderTextField(
                    name: "name",
                    decoration: const InputDecoration(
                      labelText: "Nome",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nome é obrigatório";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  FormBuilderTextField(
                    name: "email",
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email é obrigatório";
                      }
                      if (!EmailValidator.validate(value)) {
                        return "Email inválido";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  FormBuilderTextField(
                    name: "username",
                    decoration: const InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username é obrigatório";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  FormBuilderTextField(
                    name: "password",
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Senha",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Senha é obrigatório";
                      }
                      if (value.length < 6) {
                        return "Minimo de 6 digitos";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  FormBuilderTextField(
                    name: "confirmPassword",
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Confirmar senha",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final password = _formKey.currentState?.fields['password']?.value;

                      if (value != password) {
                        return "Senhas não conferem";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  Observer(
                    builder: (_) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,

                        child: ElevatedButton(
                          onPressed: store.isLoading
                              ? null
                              : () {
                                  final valid =
                                      _formKey.currentState?.saveAndValidate() ?? false;
                                  if (!valid) return;
                                  store.submit(values: _formKey.currentState!.value);
                                },
                          child: store.isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Registrar"),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    child: const Text("Já tem conta? Fazer login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
