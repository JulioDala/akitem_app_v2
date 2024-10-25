import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 11), // Adiciona margem superior para centralizar
            child: Image.asset(
              'assets/images/app_logo.png',
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 45,
              margin: const EdgeInsets.only(top: 11), // Centraliza verticalmente o campo de pesquisa
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquisa de produtos',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 11), // Centraliza o ícone de filtro verticalmente
            child: IconButton(
              icon: const Icon(
                Icons.filter_alt_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Aumenta a altura da TabBar
        child: Container(
          color: Colors.white,
          child: const TabBar(
            tabs: [
              Tab(
                // Substituindo o texto 'akitem' por uma imagem
                child: Image(
                  image: AssetImage('assets/images/app_logo_red.png'),
                  width: 100, // Definindo a largura da imagem
                  height: 40, // Definindo a altura da imagem
                  fit: BoxFit.contain, // Mantém a imagem dentro da área
                ),
              ),
              Tab(
                child: Text(
                  'Serviços',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
            indicatorColor: AppColors.secundary,
            indicatorWeight: 3,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120.0); // Mantendo a altura ajustada
}
