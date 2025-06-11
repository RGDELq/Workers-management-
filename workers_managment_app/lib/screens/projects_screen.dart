import 'package:flutter/material.dart';
import 'package:workers_managment_app/screens/single_project.dart';
import 'package:workers_managment_app/screens/widgets/arrow_back_button.dart';
import 'package:workers_managment_app/utils/theme.dart';

class ProjectListScreen extends StatelessWidget {
  final List<Map<String, String>> projects = [
    {'title': 'النجمة والهلال', 'subtitle': '63', 'workers': '22'},
    {'title': 'المطار', 'subtitle': '112', 'workers': '35'},
    {'title': 'المستشفى', 'subtitle': '111', 'workers': '41'},
    {'title': 'مبنى القابضة', 'subtitle': '13', 'workers': '22'},
  ];

  ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          title: const Text('المشاريع'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Icon(
                    Icons.location_on,
                    color: primary,
                  ),
                  title: Text(
                    project['title']!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الكود: ${project['subtitle']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'عدد العمال: ${project['workers']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleProjectScreen(
                          title: project['title']!,
                          subtitle: project['subtitle']!,
                          workers: project['workers']!,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}