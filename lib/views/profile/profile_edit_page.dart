// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _storage = const FlutterSecureStorage();
  bool isEditing = false;
  bool isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Carrega os dados do usuário a partir do storage
    String? userData = await _storage.read(key: 'user');
    if (userData != null) {
      Map<String, dynamic> user = jsonDecode(userData);
      setState(() {
        _nameController.text = user['name'] ?? '';
        _emailController.text = user['email'] ?? '';
        _contactController.text = user['contact'] ?? '';
      });
    }
  }

  Future<void> _updateUserData() async {
    setState(() {
      isLoading = true;
    });

    String? token = await _storage.read(key: 'token');
    try {
      if (token != null) {
        final response = await http.put(
          Uri.parse('https://api.akitem.ao/api/v1/update'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'name': _nameController.text,
            'email': _emailController.text,
            'contact': _contactController.text,
          }),
        );

        if (response.statusCode == 200) {
          // Atualiza os dados do usuário localmente após a atualização bem-sucedida
          await _storage.write(
              key: 'user',
              value: jsonEncode({
                'name': _nameController.text,
                'email': _emailController.text,
                'contact': _contactController.text,
              }));

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dados atualizados com sucesso!')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Erro ao atualizar os dados do usuário.')));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Erro ao atualizar os dados do usuário logado.')));
    }
    setState(() {
      isEditing = false;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Perfil',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(AppDefaults.padding),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
            vertical: AppDefaults.padding * 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: AppDefaults.borderRadius,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* <----  First Name -----> */
              const Text("Nome"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enabled: isEditing,
              ),
              const SizedBox(height: AppDefaults.padding),

              /* <---- Last Name -----> */
              const Text("Email"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                enabled: isEditing,
              ),
              const SizedBox(height: AppDefaults.padding),

              /* <---- Phone Number -----> */
              const Text("Contacto"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                enabled: isEditing,
              ),
              const SizedBox(height: AppDefaults.padding),

              /* <---- Submit -----> */
              const SizedBox(height: AppDefaults.padding),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(isEditing ? 'Salvar' : 'Editar dados'),
                  onPressed: () {
                    if (isEditing) {
                      _updateUserData();
                    } else {
                      setState(() {
                        isEditing = true;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
