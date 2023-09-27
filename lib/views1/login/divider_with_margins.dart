import 'package:flutter/material.dart';

class DividerWithMargins extends StatelessWidget {
  const DividerWithMargins({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 0.0, right: 16.0),
                child: const Divider(
                  color: Colors.white70,
                  height: 36,
                )),
          ),
          const Text(
            'OR',
            // style: TextStyle(fontFamily: 'instagram'),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 16.0, right: 0.0),
                child: const Divider(
                  color: Colors.white70,
                  height: 36,
                )),
          ),
        ],
      ),
    );
  }
}
