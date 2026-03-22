import 'package:flutter/material.dart';
import 'package:krishimitra_ai/utils/fertilizer_calculator.dart';

class FertilizerScreen extends StatefulWidget {
  const FertilizerScreen({super.key});

  @override
  State<FertilizerScreen> createState() => _FertilizerScreenState();
}

class _FertilizerScreenState extends State<FertilizerScreen> {
  final TextEditingController _areaController = TextEditingController();

  String selectedCrop = "Paddy";

  Map<String, double>? result;

  final List<String> crops = ["Paddy", "Tomato", "Cotton", "Maize"];

  void calculateFertilizer() {
    final area = double.tryParse(_areaController.text);

    if (area == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid land area")),
      );
      return;
    }

    final output =
    FertilizerCalculator.calculate(selectedCrop, area);

    setState(() {
      result = output;
    });
  }

  @override
  void dispose() {
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fertilizer Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// LAND AREA
            const Text(
              "Enter Land Area (in acres)",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _areaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "e.g. 2.5",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// CROP DROPDOWN (Better UX than typing)
            const Text(
              "Select Crop",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedCrop,
              items: crops.map((crop) {
                return DropdownMenuItem(
                  value: crop,
                  child: Text(crop),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCrop = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// CALCULATE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateFertilizer,
                child: const Text("Calculate"),
              ),
            ),

            const SizedBox(height: 30),

            /// RESULT DISPLAY
            if (result != null)
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recommended Fertilizer:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _resultItem("Urea", result!["urea"]!),
                    _resultItem("DAP", result!["dap"]!),
                    _resultItem("Potash", result!["potash"]!),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// RESULT ROW
  Widget _resultItem(String title, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        "$title: ${value.toStringAsFixed(2)} kg",
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}