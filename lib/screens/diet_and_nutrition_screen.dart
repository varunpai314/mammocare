import 'package:flutter/material.dart';

class DietAndNutritionScreen extends StatelessWidget {
  const DietAndNutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExpandableSection(
            context,
            'General Dietary Guidelines',
            'Ensure each meal includes a mix of macronutrients (carbohydrates, proteins, fats) and micronutrients (vitamins, minerals).\n'
                'Hydration: Drink plenty of fluids, primarily water, to stay hydrated.\n'
                'Consumption of 8 cups (2 liters) of water per day unless advised otherwise by your healthcare provider.',
          ),
          const SizedBox(height: 16),
          _buildExpandableSection(
            context,
            'Foods to Include',
            'Fruits and Vegetables: Include a variety of fruits and vegetables in your diet. Aim for at least 5 servings of fruits and vegetables per day.\n'
                'Whole Grains: Provides essential nutrients and help maintain energy levels. Sources: brown rice, quinoa, oats, and whole-wheat (Atta) products.\n'
                'Lean Proteins: Crucial for muscle repair and immune function. Sources: Beans, Lentils, Tofu, fish, chicken.\n'
                'Healthy Fats: Include sources of healthy fats like avocados, nuts, seeds, and olive oil. Omega-3 fatty acids found in fish and flaxseeds are particularly beneficial.\n'
                'Adequate calcium and vitamin D are important for bone health.',
          ),
          const SizedBox(height: 16),
          _buildExpandableSection(
            context,
            'Foods to Avoid or Limit',
            'Processed Foods: Minimize consumption of processed meats, sugary snacks, and high-fat fast foods.\n'
                'Simple or Starchy carbohydrates: Fruit juices, energy drinks, white bread and pasta, white rice, baked goods that contain white flour.\n'
                'Sugary Drinks: Avoid sugary beverages such as sodas, sweetened teas, and energy drinks.\n'
                'Alcohol: Limit alcohol consumption.\n'
                'Red Meat: Limit red meat intake to a few times per week and avoid processed meats like sausages and bacon.',
          ),
          const SizedBox(height: 16),
          _buildExpandableSection(
            context,
            'Special Considerations',
            'Managing Side Effects:\n'
                '- Nausea: Eat small, frequent meals. Ginger tea can help.\n'
                '- Loss of Appetite: Eat nutrient-dense foods and consider smoothies or meal replacement shakes.\n'
                '- Mouth Sores: Avoid spicy, acidic, or rough-textured foods. Opt for soft, bland foods.\n'
                'Immune Support: Include foods rich in vitamins A, C, and E, such as citrus fruits, berries, nuts, and leafy greens. Zinc-rich foods like nuts and seeds can also support immune function.\n'
                'Bone Health: Ensure adequate intake of calcium and vitamin D through dairy or fortified alternatives.',
          ),
          const SizedBox(height: 16),
          _buildExpandableSection(
            context,
            'Supplement Guidelines',
            'Vitamin and Mineral Supplements:\n'
                'Common supplements include vitamin D, calcium, and omega-3 fatty acids.\n'
                'Avoid Herbal Supplements as they can interact with treatments.\n'
                'Always consult your healthcare provider before using any herbal products.',
          ),
          const SizedBox(height: 16),
          _buildExpandableSection(
            context,
            'Personalized Nutrition',
            'Dietary Needs During Different Treatment Phases:\n'
                'Chemotherapy: Focus on protein-rich foods to support repair and immune function.\n'
                'Radiation: Stay hydrated and eat small, frequent meals to manage potential gastrointestinal side effects.\n'
                'Post-Treatment: Gradually return to a balanced diet, focusing on nutrient-dense foods to support recovery.',
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
