import 'package:flutter/material.dart';
import 'package:news_hive/utils/helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/Avatar.png'),
              ),
              vsMedium,
              Text(
                'John Doe',
                style: poppinsStyle(
                  fontSize: tsHeadLine4,
                  fontWeight: fSemiBold,
                  color: cBlack,
                ),
              ),
              Text(
                'john.doe@example.com',
                style: poppinsStyle(fontSize: tsSubtitle2, color: Colors.grey),
              ),
              vsLarge,
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Interests'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help & Support'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
