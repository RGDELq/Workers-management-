import 'package:flutter/material.dart';
import 'package:workers_managment_app/utils/theme.dart';
import 'package:workers_managment_app/screens/widgets/arrow_back_button.dart';
import 'package:workers_managment_app/screens/add_material_screen.dart';

// Material model for demonstration
class Material {
  final String name;
  final double quantity;
  final String unit;
  final DateTime dateAdded;

  Material({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.dateAdded,
  });
}

class SingleProjectScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String workers;

  const SingleProjectScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.workers,
  }) : super(key: key);

  @override
  State<SingleProjectScreen> createState() => _SingleProjectScreenState();
}

class _SingleProjectScreenState extends State<SingleProjectScreen> {
  // Sample materials data - replace this with your actual data source
  List<Material> materials = [
    Material(
      name: 'Cement',
      quantity: 50,
      unit: 'bags',
      dateAdded: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Material(
      name: 'Steel Rods',
      quantity: 25,
      unit: 'pieces',
      dateAdded: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Material(
      name: 'Sand',
      quantity: 10,
      unit: 'tons',
      dateAdded: DateTime.now(),
    ),
  ];

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
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
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMaterialScreen(
                      projectTitle: widget.title,
                      projectCode: widget.subtitle,
                    ),
                  ),
                );
                
                // Add new material to the list if returned
                if (result != null) {
                  setState(() {
                    materials.add(Material(
                      name: result['name'],
                      quantity: result['quantity'],
                      unit: result['unit'],
                      dateAdded: result['dateAdded'],
                    ));
                  });
                }
              },
              icon: Icon(
                Icons.add_circle,
                color: white,
                size: 28,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Project Info Card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Project Code',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: grey1,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.subtitle,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Workers',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: grey1,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.workers,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Materials Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Materials',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${materials.length} items',
                    style: TextStyle(
                      fontSize: 14,
                      color: white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Materials List
              Expanded(
                child: materials.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 64,
                              color: white.withOpacity(0.6),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No materials added yet',
                              style: TextStyle(
                                fontSize: 18,
                                color: white.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap the + button to add materials',
                              style: TextStyle(
                                fontSize: 14,
                                color: white.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: materials.length,
                        itemBuilder: (context, index) {
                          final material = materials[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.inventory,
                                  color: primary,
                                  size: 24,
                                ),
                              ),
                              title: Text(
                                material.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    '${material.quantity} ${material.unit}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: primary,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Added: ${_formatDate(material.dateAdded)}',
                                    style: TextStyle(
                                      color: grey1,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton(
                                icon: Icon(Icons.more_vert, color: grey1),
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, size: 20),
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, size: 20, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Delete', style: TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == 'delete') {
                                    setState(() {
                                      materials.removeAt(index);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${material.name} removed'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  // TODO: Implement edit functionality
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddMaterialScreen(
                  projectTitle: widget.title,
                  projectCode: widget.subtitle,
                ),
              ),
            );
            
            // Add new material to the list if returned
            if (result != null) {
              setState(() {
                materials.add(Material(
                  name: result['name'],
                  quantity: result['quantity'],
                  unit: result['unit'],
                  dateAdded: result['dateAdded'],
                ));
              });
            }
          },
          backgroundColor: primary,
          foregroundColor: white,
          icon: const Icon(Icons.add),
          label: const Text('Add Material'),
        ),
      ),
    );
  }
}
