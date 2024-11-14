import 'package:flutter/material.dart';
import 'package:mammocare/widgets/daily_wellness_check.dart';
import 'package:mammocare/widgets/sliding_window.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SlidingWindow(),
          const SizedBox(height: 16),
          const DailyWellnessCheckIn(),
          const SizedBox(height: 16),
          const Text('Breast Cancer Education',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          _buildExpandableSection(
            context,
            'Understanding Breast Cancer',
            'Breast cancer is a type of cancer that develops from breast tissue. It occurs when cells in the breast begin to grow uncontrollably.',
          ),
          _buildExpandableSection(
            context,
            'Types of Breast Cancer',
            'Ductal carcinoma in situ (DCIS), invasive ductal carcinoma, invasive lobular carcinoma, and other less common types.',
          ),
          _buildExpandableSection(
            context,
            'Causes and Risk Factors',
            'Genetic factors, family history, lifestyle choices, hormonal factors, and environmental influences.',
          ),
          _buildExpandableSection(
            context,
            'Breast Cancer Stages',
            'Stage 0 to Stage IV: Understanding the progression and implications of each stage.',
          ),
          _buildExpandableSection(
            context,
            'Diagnostic Tests',
            'Mammograms, ultrasounds, MRIs, biopsy, and genetic testing.',
          ),
          _buildExpandableSection(
            context,
            'Treatment Options',
            'Surgery - Lumpectomy, mastectomy, and reconstructive surgery.\n'
                'Chemotherapy - Understanding how chemotherapy works, potential side effects, and its role in breast cancer treatment.\n'
                'Radiation Therapy - External beam radiation, internal radiation, and side effects.\n'
                'Hormone Therapy - How hormone therapy targets hormone-sensitive breast cancer and its side effects.\n'
                'Targeted Therapy - Drugs that target specific abnormalities within cancer cells and their side effects.',
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
