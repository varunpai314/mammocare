import 'package:flutter/material.dart';

class PhysicalActivityScreen extends StatelessWidget {
  const PhysicalActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExpandableSection(
            context,
            'Physical Activity Benefits',
            'Improved Strength\n'
                'Weight Management\n'
                'Reduced Fatigue\n'
                'Reduced Anxiety and Depression\n'
                'Enhanced Mood\n'
                'Better Sleep',
          ),
          const SizedBox(height: 16),
          _buildExpandableSection(
            context,
            'General Exercise Guidelines',
            'Start Slowly: Begin with low-intensity activities and gradually increase the duration and intensity as your fitness level improves.\n'
                'Consistency is Key',
          ),
          const SizedBox(height: 16),
          _buildExpandableSection(
            context,
            'Types of Exercise',
            'Aerobic Exercise: Activities such as walking, jogging, cycling, and dancing. Start with at least 30 minutes per day, three days a week, for 3 weeks. Slowly increase it to five days a week.\n\n'
                'Resistance Exercise/Strength Training: Exercises such as lifting weights, resistance band exercises, and bodyweight exercises. Start with two to three sessions per week, focusing on major muscle groups.\n\n'
                'Flexibility: Activities such as yoga and stretching exercises. Aim for daily sessions to improve flexibility and reduce muscle tension.',
          ),
          const SizedBox(height: 16),
          _buildExpandableSection(
            context,
            'Exercise Plans',
            'Beginner (1-3 weeks):\n'
                '- Monday: 20-minute walk\n'
                '- Wednesday: 20-minute walk\n'
                '- Friday: 20-minute walk\n\n'
                'Intermediate (4-6 weeks):\n'
                '- Monday: 30-minute walk\n'
                '- Wednesday: 30-minute walk + 15 minutes of Resistance exercise\n'
                '- Friday: 30-minute walk\n'
                '- Saturday: 30 minutes of yoga\n\n'
                'Advanced (After 6 months):\n'
                '- Monday: 45-minute brisk walk\n'
                '- Tuesday: 30 minutes of Resistance exercise\n'
                '- Wednesday: 45-minute brisk walk\n'
                '- Thursday: 30 minutes of strength training\n'
                '- Friday: 45-minute brisk walk\n'
                '- Saturday: 30 minutes of yoga',
          ),
          const SizedBox(height: 16),
          _buildExpandableSection(
            context,
            'Special Considerations',
            'During Treatment:\n'
                '- Chemotherapy: Focus on low-intensity activities and listen to your body. Rest when needed.\n'
                '- Radiation Therapy: Gentle exercises like walking or yoga can help manage fatigue and maintain mobility.\n'
                '- Post-Surgery: Start with gentle range-of-motion exercises as recommended by your healthcare provider.\n\n'
                'Managing Side Effects:\n'
                '- Fatigue: Short, frequent bouts of activity can help manage fatigue.\n'
                '- Lymphedema: Incorporate gentle, regular exercise to promote lymphatic drainage. Avoid heavy lifting with the affected arm.\n'
                '- Pain: Choose low-impact activities that do not exacerbate pain.',
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(
      BuildContext context, String title, String content) {
    return ExpansionTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
