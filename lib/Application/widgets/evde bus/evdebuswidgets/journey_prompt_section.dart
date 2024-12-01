import 'package:flutter/material.dart';

class JourneyPromptSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Prompt your entire journey',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19),
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19),
                    borderSide: BorderSide(
                        color: Colors.deepPurple,
                        width:
                            2.0)),
                suffix: Icon(
                  Icons.lock_open_outlined,
                  size: 18,
                )),
            minLines: 3,
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
