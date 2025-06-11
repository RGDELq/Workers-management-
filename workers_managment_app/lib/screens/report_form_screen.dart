import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:workers_managment_app/screens/utils/theme.dart';
import 'package:workers_managment_app/screens/widgets/CustomDropdown.dart';
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
  final TextEditingController _workStatementController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? workLocation;
  String? engineer;
  String? technician;
  String? workGroup;

  List<PlatformFile> pickedFiles = [];

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withReadStream: true,
    );
    if (result != null && result.files.length <= 6) {
      setState(() {
        pickedFiles = result.files;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يمكنك اختيار حتى 6 صور كحد أقصى')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('إضافة تقرير'),
          centerTitle: true,
          backgroundColor: primary,
          leading: const ArrowBackButton(),
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomTextField(
                    controller: _projectNameController,
                    label: 'اسم المشروع:',
                  ),
                  const SizedBox(height: 12),
                  CustomDropdown(
                    label: 'موقع العمل:',
                    value: workLocation,
                    items: const ['الرياض', 'جدة', 'مكة'],
                    onChanged: (val) => setState(() => workLocation = val),
                  ),
                  const SizedBox(height: 12),
                  CustomDropdown(
                    label: 'المهندس:',
                    value: engineer,
                    items: const ['المهندس 1', 'المهندس 2'],
                    onChanged: (val) => setState(() => engineer = val),
                  ),
                  const SizedBox(height: 12),
                  CustomDropdown(
                    label: 'الفني:',
                    value: technician,
                    items: const ['فني 1', 'فني 2'],
                    onChanged: (val) => setState(() => technician = val),
                  ),
                  const SizedBox(height: 12),
                  CustomDropdown(
                    label: 'مجموعة العمل:',
                    value: workGroup,
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
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),

                  OutlinedButton.icon(
                    onPressed: _pickFiles,
                    icon:  Icon(Icons.attach_file, color: primary),
                    label: Text(
                      pickedFiles.isEmpty ? 'اختر ملفات (حتى 6 صور)' : '${pickedFiles.length} ملف مختار',
                      style: TextStyle(color: primary),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                  ),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم إرسال التقرير بنجاح!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      backgroundColor: primary,
                    ),
                    child: const Text(
                      'إرسال التقرير',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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

