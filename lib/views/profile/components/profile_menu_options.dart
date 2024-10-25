import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Certifique-se de ter esse pacote

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import 'profile_list_tile.dart';

class ProfileMenuOptions extends StatelessWidget {
  const ProfileMenuOptions({
    super.key,
  });

  // Instância do storage seguro
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Função de logout que limpa o storage e redireciona para a página de login
  Future<void> _logout(BuildContext context) async {
    await _storage.delete(key: 'token'); // Apaga o token armazenado
    await _storage.delete(key: 'user');  // Apaga os dados do usuário

    // Redireciona para a página de login
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginOrSignup,
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.padding),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppDefaults.boxShadow,
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Column(
        children: [
          ProfileListTile(
            title: 'Meus Dados',
            icon: Icons.person,
            onTap: () => Navigator.pushNamed(context, AppRoutes.profileEdit),
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Notificações',
            icon: Icons.notifications,
            onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Definições',
            icon: Icons.settings,
            onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Pagamentos',
            icon: Icons.account_balance_wallet,
            onTap: () => Navigator.pushNamed(context, AppRoutes.paymentMethod),
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Sair',
            icon: Icons.logout,
            onTap: () => _logout(context), // Chama a função de logout
          ),
        ],
      ),
    );
  }
}
