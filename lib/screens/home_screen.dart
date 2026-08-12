import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Complete Flutter course',
      'description': 'Finish the Firebase authentication lesson',
      'priority': 'High',
      'completed': false,
    },
    {
      'title': 'Build Task Manager',
      'description': 'Create the home screen UI',
      'priority': 'High',
      'completed': false,
    },
    {
      'title': 'Study Firebase',
      'description': 'Learn Firestore database operations',
      'priority': 'Medium',
      'completed': false,
    },
    {
      'title': 'Practice Dart',
      'description': 'Practice classes and async programming',
      'priority': 'Low',
      'completed': true,
    },
  ];

  int get _completedTasks {
    return _tasks.where((task) => task['completed'] == true).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      // ------------------------------------------------------------
      // APP BAR
      // ------------------------------------------------------------

      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: const Color(0xFF5B5FEF),
      //   foregroundColor: Colors.white,

      //   title: const Text(
      //     'Task Manager',
      //     style: TextStyle(
      //       fontSize: 21,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),

      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         // Search functionality
      //       },
      //       icon: const Icon(Icons.search_rounded),
      //     ),

      //     IconButton(
      //       onPressed: () {
      //         // Profile/settings
      //       },
      //       icon: const Icon(Icons.account_circle_outlined),
      //     ),

      //     const SizedBox(width: 8),
      //   ],
      // ),

      // ------------------------------------------------------------
      // ADD TASK BUTTON
      // ------------------------------------------------------------

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddTaskDialog();
        },
        backgroundColor: const Color(0xFF5B5FEF),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Task',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ------------------------------------------------------------
      // BODY
      // ------------------------------------------------------------

      body: SafeArea(
        child: Column(
          children: [

            // --------------------------------------------------------
            // HEADER
            // --------------------------------------------------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                24,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF5B5FEF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Good morning 👋',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Let\'s get things done!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --------------------------------------------------
                  // TASK SUMMARY
                  // --------------------------------------------------

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [

                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 28,
                        ),

                        const SizedBox(width: 12),

                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$_completedTasks of ${_tasks.length} tasks completed',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              'Keep up the good work!',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --------------------------------------------------------
            // TASK LIST
            // --------------------------------------------------------

            Expanded(
              child: _tasks.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        20,
                        16,
                        100,
                      ),
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return _buildTaskCard(
                          index,
                          _tasks[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // TASK CARD
  // ================================================================

  Widget _buildTaskCard(
    int index,
    Map<String, dynamic> task,
  ) {
    final bool completed = task['completed'];
    final String priority = task['priority'];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [

            // --------------------------------------------------------
            // CHECK BUTTON
            // --------------------------------------------------------

            GestureDetector(
              onTap: () {
                setState(() {
                  _tasks[index]['completed'] = !completed;
                });
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: completed
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFF0F0FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  completed
                      ? Icons.check_rounded
                      : Icons.task_alt_rounded,
                  color: completed
                      ? Colors.green
                      : const Color(0xFF5B5FEF),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // --------------------------------------------------------
            // TASK INFORMATION
            // --------------------------------------------------------

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    task['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      decoration: completed
                          ? TextDecoration.lineThrough
                          : null,
                      color: completed
                          ? Colors.grey
                          : const Color(0xFF1F2937),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    task['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      decoration: completed
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  const SizedBox(height: 9),

                  // Priority
                  _priorityBadge(priority),
                ],
              ),
            ),

            // --------------------------------------------------------
            // MORE BUTTON
            // --------------------------------------------------------

            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.grey.shade600,
              ),
              onSelected: (value) {
                if (value == 'delete') {
                  setState(() {
                    _tasks.removeAt(index);
                  });
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined),
                      SizedBox(width: 10),
                      Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // PRIORITY BADGE
  // ================================================================

  Widget _priorityBadge(String priority) {
    Color color;

    switch (priority) {
      case 'High':
        color = Colors.red;
        break;

      case 'Medium':
        color = Colors.orange;
        break;

      default:
        color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ================================================================
  // EMPTY STATE
  // ================================================================

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEEFF),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.task_alt_rounded,
              size: 45,
              color: Color(0xFF5B5FEF),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'No tasks yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Tap "Add Task" to create your first task.',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // ADD TASK DIALOG
  // ================================================================

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add New Task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Task title',
                  prefixIcon: const Icon(
                    Icons.task_alt_rounded,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              TextField(
                controller: descriptionController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: const Icon(
                    Icons.description_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  _tasks.add({
                    'title': titleController.text.trim(),
                    'description':
                        descriptionController.text.trim(),
                    'priority': 'Medium',
                    'completed': false,
                  });
                });

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B5FEF),
                foregroundColor: Colors.white,
              ),
              child: const Text('Add Task'),
            ),
          ],
        );
      },
    );
  }
}