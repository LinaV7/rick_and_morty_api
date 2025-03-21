import 'package:flutter/material.dart';
import 'package:rick_and_morty/ui/theme/colors.dart';

class FiltersWidget extends StatelessWidget {
  final List<String> filters;
  final List<String> filters2;
  final String selectedFilter;
  final String selectedFilter2;
  final Function(String) onFilterChanged;
  final Function(String) onFilter2Changed;

  const FiltersWidget({
    super.key,
    required this.filters,
    required this.filters2,
    required this.selectedFilter,
    required this.selectedFilter2,
    required this.onFilterChanged,
    required this.onFilter2Changed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Фильтр по виду
        SizedBox(
          height: 60,
          child: ListView.builder(
            itemCount: filters.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final filter = filters[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    onFilterChanged(filter);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: selectedFilter == filter
                          ? AppColors.secondary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color.fromRGBO(245, 247, 249, 1),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Center(
                      child: Text(
                        filter,
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedFilter == filter
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Фильтр по статусу
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 10.0, bottom: 10.0, right: 20.0),
              child: Text(
                'Status ',
              ),
            ),
            DropdownButton<String>(
              value: selectedFilter2,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onFilter2Changed(newValue);
                }
              },
              items: filters2.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
