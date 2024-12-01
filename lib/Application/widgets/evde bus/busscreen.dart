import 'package:flutter/material.dart';
import 'evdebuswidgets/journey_prompt_section.dart';
import 'evdebuswidgets/news_updates_section.dart';
import 'evdebuswidgets/search_bus_section.dart';
import 'evdebuswidgets/service_section.dart';

class BusScreen extends StatefulWidget {
  const BusScreen({super.key});

  @override
  State<BusScreen> createState() => _BusScreenState();
}

class _BusScreenState extends State<BusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:  [
            SearchSection(),
            SizedBox(height: 20),
            ServiceSection(),
            SizedBox(height: 15),
            NewsUpdatesSection(),
            SizedBox(height: 20),
            JourneyPromptSection(),
          ],
        ),
      ),
    );
  }
}
