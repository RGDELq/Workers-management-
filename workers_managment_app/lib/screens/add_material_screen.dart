import 'package:flutter/material.dart';
import 'package:workers_managment_app/utils/theme.dart';
import 'package:workers_managment_app/screens/widgets/arrow_back_button.dart';
import 'package:workers_managment_app/screens/widgets/text_field_widget.dart';
import 'package:workers_managment_app/screens/widgets/CustomDropdown.dart';
import 'package:workers_managment_app/screens/widgets/primary_button.dart';

class AddMaterialScreen extends StatefulWidget {
  final String projectTitle;
  final String projectCode;

  const AddMaterialScreen({
    Key? key,
    required this.projectTitle,
    required this.projectCode,
  }) : super(key: key);

  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {
  final _formKey = GlobalKey<FormState>();
  final _materialNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _materialNameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // TODO: Implement your submission logic here
      // For now, just show a success message
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        // Create the material object to return
        final newMaterial = {
          'name': _materialNameController.text.trim(),
          'quantity': double.parse(_quantityController.text.trim()),
          'unit': _unitController.text.trim(),
          'dateAdded': _selectedDate,
        };

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Material added successfully!'),
            backgroundColor: primary,
          ),
        );
        
        // Return the new material data
        Navigator.pop(context, newMaterial);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, const Color(0xFFECE9E6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: const ArrowBackButton(),
          title: const Text('Add material'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // Location (Project Name - Read Only)
                const Text(
                  'Location:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: primary.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.projectTitle.isNotEmpty ? widget.projectTitle[0].toUpperCase() : 'P',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.projectTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),

                // Material Name
                TextFieldWidget(
                  controller: _materialNameController,
                  label: 'Material name:',
                  hintText: 'Enter material name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter material name';
                    }
                    return null;
                  },
                  fillColor: Colors.white,
                  filled: true,
                ),

                const SizedBox(height: 10),

                // Quantity
                TextFieldWidget(
                  controller: _quantityController,
                  label: 'Quantity:',
                  hintText: 'Enter quantity',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter quantity';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  fillColor: Colors.white,
                  filled: true,
                ),

                const SizedBox(height: 10),

                // Unit
                TextFieldWidget(
                  controller: _unitController,
                  label: 'Unit:',
                  hintText: 'Enter unit (e.g., kg, liters, pieces)',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter unit';
                    }
                    return null;
                  },
                  fillColor: Colors.white,
                  filled: true,
                ),

                const SizedBox(height: 20),

                // Date
                const Text(
                  'Date:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: primary.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _formatDate(_selectedDate),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: primary),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Submit Button
                Center(
                  child: PrimaryButton(
                    text: 'Submit',
                    withBorder: false,
                    isLoading: _isLoading,
                    widthFromScreen: 0.8,
                    onPressed: _submitForm,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 