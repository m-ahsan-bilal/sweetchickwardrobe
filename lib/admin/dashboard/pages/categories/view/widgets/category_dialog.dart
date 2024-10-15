import 'package:flutter/material.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class CategoryDialog extends StatefulWidget {
  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final _imageUrlController = TextEditingController();
  final _categoryNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _imageUrlController,
            decoration: InputDecoration(labelText: 'Image URL'),
          ),
          TextField(
            controller: _categoryNameController,
            decoration: InputDecoration(labelText: 'Category Name'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final imageUrl = _imageUrlController.text;
            final categoryName = _categoryNameController.text;
            final description = _descriptionController.text;

            if (imageUrl.isNotEmpty && categoryName.isNotEmpty && description.isNotEmpty) {
              Navigator.of(context).pop({
                'image_url': imageUrl,
                'category_name': categoryName,
                'description': description,
              });
            } else {
              // Show error or validation
              ZBotToast.showToastError(title: "0ops!",message: "Please fill in all required fields");
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
