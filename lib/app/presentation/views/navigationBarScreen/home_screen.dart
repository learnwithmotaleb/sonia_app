import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = "Alex"; // You can fetch this from a provider or service

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
            child: const Text("Hey, Abdul")),
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreeting(userName),
            const SizedBox(height: 20),
            _buildQuickActions(context),
            const SizedBox(height: 30),
            _buildAssistantBox(),
            const SizedBox(height: 30),
            _buildRecentActivity(),
            const SizedBox(height: 30),
            _buildStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting(String name) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? "Good Morning"
        : hour < 17
        ? "Good Afternoon"
        : "Good Evening";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$greeting, $name 👋",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          "${DateTime.now().toLocal()}".split('.')[0], // date & time
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _actionCard(Icons.note, "Notes", () {}),
        _actionCard(Icons.calendar_today, "Reminders", () {}),
        _actionCard(Icons.lightbulb, "Suggestions", () {}),
        _actionCard(Icons.task, "Tasks", () {}),
      ],
    );
  }

  Widget _actionCard(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 150,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(icon, size: 32, color: Colors.blueAccent),
                const SizedBox(height: 10),
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAssistantBox() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("🤖 Assistant", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("How can I help you today?"),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Ask me anything...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.check_circle_outline),
          title: Text("Completed 'Grocery List'"),
        ),
        ListTile(
          leading: Icon(Icons.note_add_outlined),
          title: Text("Added note 'Meeting Summary'"),
        ),
        ListTile(
          leading: Icon(Icons.alarm),
          title: Text("Reminder: 'Doctor's appointment'"),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Column(
              children: [
                Text("5", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("Tasks Done"),
              ],
            ),
            Column(
              children: [
                Text("78%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("Focus Score"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
