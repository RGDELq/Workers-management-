import 'package:flutter/material.dart';
import 'package:workers_managment_app/utils/theme.dart';
import 'package:workers_managment_app/screens/widgets/custom_bottom_nav.dart';

class WorkersScreen extends StatefulWidget {
  const WorkersScreen({super.key});

  @override
  State<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  TextEditingController searchController = TextEditingController();
  List<Worker> allWorkers = [];
  List<Worker> filteredWorkers = [];

  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    allWorkers = [
      Worker(name: 'أحمد محمد', jobTitle: 'مهندس', projectName: '36'),
      Worker(name: 'فاطمة علي', jobTitle: 'مهندسة', projectName: '22'),
      Worker(name: 'محمد حسن', jobTitle: 'عامل', projectName: '50'),
      Worker(name: 'سارة أحمد', jobTitle: 'مشرفة', projectName: '56'),
      Worker(name: 'علي محمود', jobTitle: 'فني', projectName: '56'),
      Worker(name: 'نور الدين', jobTitle: 'مهندس', projectName: '14'),
      Worker(name: 'ليلى حسام', jobTitle: 'محاسبة', projectName: '57'),
      Worker(name: 'خالد عبدالله', jobTitle: 'عامل', projectName: 'مشروع المياه'),
      Worker(name: 'مريم سالم', jobTitle: 'مهندسة', projectName: 'مشروع الكهرباء'),
      Worker(name: 'يوسف إبراهيم', jobTitle: 'مشرف', projectName: 'مشروع البناء الأول'),
      Worker(name: 'هدى محمد', jobTitle: 'فنية', projectName: 'مشروع الطرق'),
      Worker(name: 'عمر حسين', jobTitle: 'عامل', projectName: 'مشروع البناء الثاني'),
      Worker(name: 'زينب أحمد', jobTitle: 'مهندسة', projectName: 'مشروع المياه'),
    ];
    filteredWorkers = allWorkers;
    searchController.addListener(_filterWorkers);
  }

  void _filterWorkers() {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredWorkers = allWorkers;
      } else {
        filteredWorkers = allWorkers.where((worker) {
          return worker.name.toLowerCase().contains(query) ||
                 worker.jobTitle.toLowerCase().contains(query) ||
                 worker.projectName.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
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
                child: Column(
                  children: [
                    // Back button and title
                    Row(
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
                            '${13} عامل',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Search Bar
                    Container(
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
                        child: TextField(
                          controller: searchController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'البحث عن عامل...',
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[500],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Workers List
              Expanded(
                child: filteredWorkers.isEmpty
                    ? const Center(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            'لا توجد نتائج',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: filteredWorkers.length + 1, // +1 for "Load more" button
                        itemBuilder: (context, index) {
                          if (index == filteredWorkers.length) {
                            // Load more button
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    // Implement load more functionality
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('تحميل المزيد...'),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'تحميل المزيد...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          
                          return _WorkerCard(worker: filteredWorkers[index]);
                        },
                      ),
              ),
              
              const SizedBox(height: 100), // Space for bottom navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        onReportsPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reports tapped')),
          );
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
}

class _WorkerCard extends StatelessWidget {
  final Worker worker;

  const _WorkerCard({required this.worker});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Row(
          children: [
            // Profile Picture
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: Colors.grey[600],
                size: 30,
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Worker Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    worker.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${worker.jobTitle} • ${worker.projectName}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Worker {
  final String name;
  final String jobTitle;
  final String projectName;

  Worker({
    required this.name,
    required this.jobTitle,
    required this.projectName,
  });
} 