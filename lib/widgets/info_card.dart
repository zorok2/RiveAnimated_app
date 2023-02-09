import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        'Vu Trong Nghia',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Youtuber ',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
