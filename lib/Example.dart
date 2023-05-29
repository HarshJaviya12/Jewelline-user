import 'package:flutter/material.dart';

class MyCategoryPage extends StatefulWidget {
  const MyCategoryPage({Key? key}) : super(key: key);

  @override
  _MyCategoryPageState createState() => _MyCategoryPageState();
}

class _MyCategoryPageState extends State<MyCategoryPage> {
  String? selectedCategory;
  String? selectedSubcategory;
  List<String> categories = ['Fruits', 'Vegetables', 'Meat'];
  Map<String, List<String>> subcategories = {
    'Fruits': ['Apples', 'Oranges', 'Bananas'],
    'Vegetables': ['Carrots', 'Peppers', 'Broccoli'],
    'Meat': ['Beef', 'Chicken', 'Pork'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Dropdown Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Select a category'),
          ),
          DropdownButtonFormField<String>(
            value: selectedCategory,
            onChanged: (String? value) {
              setState(() {
                selectedCategory = value;
                selectedSubcategory = null;
              });
            },
            items: categories
                .map((category) => DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            ))
                .toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          if (selectedCategory != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select a subcategory'),
                  DropdownButtonFormField<String>(
                    value: selectedSubcategory,
                    onChanged: (String? value) {
                      setState(() {
                        selectedSubcategory = value;
                      });
                    },
                    items: subcategories[selectedCategory]!
                        .map((subcategory) => DropdownMenuItem<String>(
                      value: subcategory,
                      child: Text(subcategory),
                    ))
                        .toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
