import 'package:flutter/cupertino.dart';

class SecoundListPage extends StatefulWidget {
  final String title;
  final Color color;

  const SecoundListPage({super.key, required this.title, required this.color});

  @override
  State<StatefulWidget> createState() => SecoundListPageState();
}

class SecoundListPageState extends State<SecoundListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: Center(
        child: Text(
          widget.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
