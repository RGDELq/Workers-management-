import 'package:flutter/material.dart';
import 'package:workers_managment_app/utils/theme.dart';
import 'package:workers_managment_app/screens/widgets/main_bottom_navigation.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Report> pendingReports = [
    Report(
      userName: 'محمد',
      description: 'تركيب كابلات',
      date: '12-12-2024',
      id: '1',
    ),
    Report(
      userName: 'محمد',
      description: 'تركيب كابلات',
      date: '12-12-2024',
      id: '2',
    ),
    Report(
      userName: 'محمد',
      description: 'تركيب كابلات',
      date: '12-12-2024',
      id: '3',
    ),
    Report(
      userName: 'محمود',
      description: 'تمديد 12 عدد من الكابلات',
      date: '1-1-2025',
      id: '4',
      
    ),
  ];
  
  final List<Report> acceptedReports = [
    Report(
      userName: 'محمد',
      description: 'تركيب كابلات',
      date: '12-12-2024',
      id: '5',
    ),
    Report(
      userName: 'محمد',
      description: 'تركيب كابلات',
      date: '12-12-2024',
      id: '6',
    ),
    Report(
      userName: 'محمد',
      description: 'تركيب كابلات',
      date: '12-12-2024',
      id: '7',
    ),
  ];

  final List<Report> rejectedReports = [
    Report(
      userName: 'محمد',
      description: 'تركيب كابلات',
      date: '10-12-2024',
      id: '8',
      rejectionReason: 'عدم اكتمال 10 وحدات',
    ),
    Report(
      userName: 'أحمد',
      description: 'صيانة المعدات',
      date: '08-12-2024',
      id: '9',
      rejectionReason: 'التقرير غير مفصل بما فيه الكفاية',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primary, const Color(0xFFECE9E6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'التقارير',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Tab Bar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: primary,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey[600],
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                  tabs: const [
                    Tab(text: 'المعلقة'),
                    Tab(text: 'المقبولة'),
                    Tab(text: 'المرفوضة'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Tab Views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Pending Reports
                    _buildReportsList(pendingReports, isPending: true),
                    // Accepted Reports
                    _buildReportsList(acceptedReports, isPending: false),
                    // Rejected Reports
                    _buildReportsList(rejectedReports, isPending: false, isRejected: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        onReportsPressed: () {
          // Already on reports screen
        },
        onAddReportPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Report tapped')),
          );
        },
        onProfilePressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile tapped')),
          );
        },
      ),
    );
  }

  Widget _buildReportsList(List<Report> reports, {required bool isPending, bool isRejected = false}) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return _ReportCard(
          report: reports[index],
          isPending: isPending,
          isRejected: isRejected,
          onEdit: isPending ? () => _editReport(reports[index]) : null,
          onDelete: isPending ? () => _deleteReport(reports[index]) : null,
          onRejectionFeedback: isRejected ? () => _showRejectionFeedback(reports[index]) : null,
        );
      },
    );
  }

  void _editReport(Report report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController descriptionController = 
            TextEditingController(text: report.description);
        
        return AlertDialog(
          title: const Directionality(
            textDirection: TextDirection.rtl,
            child: Text('تعديل التقرير'),
          ),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: descriptionController,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    labelText: 'وصف التقرير',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تعديل التقرير بنجاح')),
                );
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  void _deleteReport(Report report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Directionality(
            textDirection: TextDirection.rtl,
            child: Text('حذف التقرير'),
          ),
          content: const Directionality(
            textDirection: TextDirection.rtl,
            child: Text('هل أنت متأكد من حذف هذا التقرير؟'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  pendingReports.removeWhere((r) => r.id == report.id);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حذف التقرير بنجاح')),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  void _showRejectionFeedback(Report report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with back arrow
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'ملاحظات',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                const Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    'تم رفض تقريرك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Rejection reason
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      report.rejectionReason ?? 'لا يوجد سبب محدد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Edit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _editRejectedReport(report);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8D6E63),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'تعديل',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editRejectedReport(Report report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController descriptionController = 
            TextEditingController(text: report.description);
        
        return AlertDialog(
          title: const Directionality(
            textDirection: TextDirection.rtl,
            child: Text('تعديل التقرير المرفوض'),
          ),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: descriptionController,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    labelText: 'وصف التقرير',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  // Remove from rejected reports
                  rejectedReports.removeWhere((r) => r.id == report.id);
                  // Add to pending reports with updated description
                  pendingReports.add(Report(
                    id: report.id,
                    userName: report.userName,
                    description: descriptionController.text,
                    date: DateTime.now().toString().substring(0, 10),
                  ));
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إعادة إرسال التقرير إلى المعلقة')),
                );
              },
              child: const Text('حفظ وإعادة إرسال'),
            ),
          ],
        );
      },
    );
  }
}

class _ReportCard extends StatelessWidget {
  final Report report;
  final bool isPending;
  final bool isRejected;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onRejectionFeedback;

  const _ReportCard({
    required this.report,
    required this.isPending,
    required this.isRejected,
    this.onEdit,
    this.onDelete,
    this.onRejectionFeedback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isRejected ? onRejectionFeedback : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      report.userName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  if (isPending)
                    Transform.translate(
                      offset: const Offset(0, 25),
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, color: Colors.grey),
                        onSelected: (value) {
                          if (value == 'edit') {
                            onEdit?.call();
                          } else if (value == 'delete') {
                            onDelete?.call();
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 18),
                                  SizedBox(width: 8),
                                  Text('تعديل'),
                                ],
                              ),
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                children: [
                                  Icon(Icons.delete, size: 18, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('حذف', style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (report.isImportant)
                    const Icon(
                      Icons.priority_high,
                      color: Colors.red,
                      size: 20,
                    ),
                  if (isRejected)
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                report.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                report.date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Report {
  final String id;
  final String userName;
  final String description;
  final String date;
  final bool isImportant;
  final String? rejectionReason;

  Report({
    required this.id,
    required this.userName,
    required this.description,
    required this.date,
    this.isImportant = false,
    this.rejectionReason,
  });
} 