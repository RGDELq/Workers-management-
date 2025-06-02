import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:workers_managment_app/screens/utils/theme.dart';
import 'package:workers_managment_app/screens/widgets/arrow_back_button.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddReportScreen(),
    ));

class AddReportScreen extends StatefulWidget { 
  const AddReportScreen({super.key});

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}
   class _AddReportScreenState extends State<AddReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _workStatementController =
      TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? workLocation;
  String? engineer;
  String? technician;
  String? workGroup;


  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withReadStream: true,
    );
    if (result != null && result.files.length <= 6) {
      setState(() {
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Max 6 pictures allowed.')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  const ArrowBackButton(),
                  const Center(
                    child: Text(
                      'إضافة تقرير',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _projectNameController,
                    label: 'اسم المشروع:',
                  ),
                  const SizedBox(height: 12),
                  CustomDropdown(
                    value: workLocation,
                    label: 'موقع العمل:',
                    items: const ['الرياض', 'جدة', 'مكة'],
                    onChanged: (val) => setState(() => workLocation = val),
                  ),
                  const SizedBox(height: 12),
                  CustomDropdown(
                    value: engineer,
                    label: 'المهندس:',
                    items: const ['المهندس 1', 'المهندس 2'],
                    onChanged: (val) => setState(() => engineer = val),
                  ),
                  const SizedBox(height: 12),
                  CustomDropdown(
                    value: technician,
                    label: 'الفني:',
                    items: const ['فني 1', 'فني 2'],
                    onChanged: (val) => setState(() => technician = val),
                  ),
                  const SizedBox(height: 12),
                  CustomDropdown(
                    value: workGroup,
                    label: 'مجموعة العمل:',
                    items: const ['المجموعة أ', 'المجموعة ب'],
                    onChanged: (val) => setState(() => workGroup = val),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: _workStatementController,
                    label: 'بيان العمل:',
                    maxLines: 5,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: _notesController,
                    label: 'ملاحظات:',
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _pickFiles,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color:primary  ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: Text(
                      'Browse File',
                      style: TextStyle(color: primary),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Max: 6 pic',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form Submitted')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: (value) =>
              value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          validator: (val) => val == null ? 'اختر قيمة' : null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
        ),
      ],
    );
  }
}