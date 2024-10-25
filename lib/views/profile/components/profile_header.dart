import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';
import 'profile_header_options.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background
        Image.asset('assets/images/profile_background.png'),

        /// Content
        Column(
          children: [
            AppBar(
              title: const Text('Perfil'),
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const _UserData(), // Exibe dados dinâmicos do usuário
            const ProfileHeaderOptions(),
          ],
        ),
        
      ],
    );
  }
}

class _UserData extends StatelessWidget {
  const _UserData();

  Future<Map<String, dynamic>> _getUserData() async {
    const storage = FlutterSecureStorage();
    final userDataString = await storage.read(key: 'user');
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar dados do usuário'));
        }

        final userData = snapshot.data!;
        final userName = userData['name'] ?? 'Usuário';
        final userEmail = userData['email'] ?? 'email@example.com';
        final userImage = userData['avatar'] ?? 'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80';

        return Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Row(
            mainAxisSize: MainAxisSize.min,  // Ajuste para ocupar apenas o espaço necessário verticalmente
            children: [
               const SizedBox(width: AppDefaults.padding),
               SizedBox(
                width: 100,
                height: 100,
                child: ClipOval(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: NetworkImageWithLoader(
                      '$userImage',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppDefaults.padding),
              Expanded(  // Expande para ocupar todo o espaço disponível horizontalmente
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$userEmail',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}