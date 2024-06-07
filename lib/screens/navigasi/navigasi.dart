import 'package:flutter/material.dart';

class navigasi extends StatelessWidget {
  const navigasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                icon: ImageIcon(AssetImage('lib/images/home.png')),
                tooltip: 'Home',
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/schedule');
                },
                icon: ImageIcon(AssetImage('lib/images/schedule.png')),
                tooltip: 'Schedule',
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/information');
                },
                icon: ImageIcon(AssetImage('lib/images/info.png')),
                tooltip: 'Information',
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/profile');
                },
                icon: ImageIcon(AssetImage('lib/images/profile.png')),
                tooltip: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
