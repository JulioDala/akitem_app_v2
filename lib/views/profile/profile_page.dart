import 'package:akitem/core/components/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'components/profile_header.dart';
import 'components/profile_menu_options.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold( // Usando Scaffold
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            ProfileMenuOptions(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(), // Adicionando o Bottom Navigation Bar
    );
  }
}
