import 'package:akitem/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

// Início da classe CustomAppBar (StatefulWidget)
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
} // Fim da classe CustomAppBar

// Início da classe _CustomAppBarState
class _CustomAppBarState extends State<CustomAppBar> with SingleTickerProviderStateMixin {
  bool _isSearching = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  } // Fim do initState

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  } // Fim do dispose

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _searchController.clear();
      }
    });
  } // Fim do _toggleSearch

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: _isSearching
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              onPressed: _toggleSearch,
            )
          : IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
      title: _isSearching
          ? AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return SizeTransition(
                  sizeFactor: _animation,
                  axis: Axis.horizontal,
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Pesquisar',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                    autofocus: true,
                  ),
                );
              },
            )
          : const Text(
              'Loja',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white, size: 20),
          onPressed: _toggleSearch,
        ),
        if (!_isSearching)
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white, size: 20),
            onPressed: () {},
          ),
      ],
    );
  } // Fim do build
} // Fim da classe _CustomAppBarState