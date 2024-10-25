import 'package:akitem/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  final Map<Color, bool> selectedColors = {
    Colors.black: false,
    Colors.blue: false,
    Colors.red: false,
    Colors.yellow: false,
    Colors.brown: false,
    Colors.green: false,
  };

  final Map<String, bool> selectedCategories = {
    'Tecnologia': false,
    'Electrodoméstico': false,
    'Livros': false,
    'Iluminação': false,
    'Banheiro': false,
    'Vestuário': false,
    'Ferramentas': false,
  };

  final Map<String, bool> selectedBrands = {
    'Apple': false,
    'Worten': false,
    'Microsoft': false,
    'HP': false,
  };

  final Map<int, bool> selectedRatings = {
    5: false,
    4: false,
    3: false,
    2: false,
    1: false,
  };

  final Map<String, bool> selectedSizes = {
    'S': false,
    'M': false,
    'L': false,
  };

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }

  Widget _buildCheckboxSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 48, // Largura da linha laranja
                height: 2, // Altura da linha
                color: Colors.amber, // Cor laranja/âmbar
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCheckboxItem({
    required String text,
    required bool value,
    required Function(bool?) onChanged,
    Widget? trailing,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 28,
          height: 28,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            shape: const CircleBorder(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              // Removido o fontWeight para usar o peso normal padrão
            ),
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filtros',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          // Categorias
                          _buildCheckboxSection(
                            title: 'Categorias',
                            child: Column(
                              children: selectedCategories.entries.map((entry) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: _buildCheckboxItem(
                                    text: entry.key,
                                    value: entry.value,
                                    onChanged: (bool? value) {
                                      setModalState(() {
                                        selectedCategories[entry.key] =
                                            value ?? false;
                                      });
                                    },
                                    trailing: Text(
                                      '(${entry.key == 'Tecnologia' ? '54' : '37'})',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          // Preço
                          _buildCheckboxSection(
                            title: 'Preço',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _minController,
                                        decoration: const InputDecoration(
                                          labelText: 'Mín',
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: TextField(
                                        controller: _maxController,
                                        decoration: const InputDecoration(
                                          labelText: 'Máx',
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    setModalState(() {
                                      _minController.clear();
                                      _maxController.clear();
                                    });
                                  },
                                  child: const Text(
                                    'Limpar intervalo',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Modificação da seção de cores
                          _buildCheckboxSection(
                            title: 'Cor',
                            child: Container(
                              width: double
                                  .infinity, // Garante que ocupe toda a largura
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: selectedColors.entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () {
                                      setModalState(() {
                                        selectedColors[entry.key] =
                                            !entry.value;
                                      });
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: entry.key,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        if (entry.value)
                                          const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),

// Modificação da seção de classificação
                          _buildCheckboxSection(
                            title: 'Classificação',
                            child: Column(
                              children: selectedRatings.entries.map((entry) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: Checkbox(
                                          value: entry.value,
                                          onChanged: (bool? value) {
                                            setModalState(() {
                                              selectedRatings[entry.key] =
                                                  value ?? false;
                                            });
                                          },
                                          shape: const CircleBorder(),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      _buildRatingStars(entry
                                          .key), // Estrelas alinhadas à esquerda
                                      Expanded(
                                          child:
                                              Container()), // Espaço flexível entre estrelas e quantidade
                                      Text(
                                        '(${entry.key == 5 ? '54' : '37'})',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          // Tamanho
                          _buildCheckboxSection(
                            title: 'Tamanho',
                            child: Column(
                              children: selectedSizes.entries.map((entry) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: _buildCheckboxItem(
                                    text: entry.key,
                                    value: entry.value,
                                    onChanged: (bool? value) {
                                      setModalState(() {
                                        selectedSizes[entry.key] =
                                            value ?? false;
                                      });
                                    },
                                    trailing: Text(
                                      '(${entry.key == 'L' ? '60' : '12'})',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          // Marcas
                          _buildCheckboxSection(
                            title: 'Marcas',
                            child: Column(
                              children: selectedBrands.entries.map((entry) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: _buildCheckboxItem(
                                    text: entry.key,
                                    value: entry.value,
                                    onChanged: (bool? value) {
                                      setModalState(() {
                                        selectedBrands[entry.key] =
                                            value ?? false;
                                      });
                                    },
                                    trailing: Text(
                                      '(${entry.key == 'Aplle' ? '54' : '37'})',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement filter logic here
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secundary,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('FILTRAR'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: _showFilters,
      icon: const Icon(Icons.tune, size: 16),
      label: const Text('FILTRAR', style: TextStyle(fontSize: 11)),
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
