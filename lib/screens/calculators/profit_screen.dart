import 'package:flutter/material.dart';
import 'package:krishimitra_ai/utils/profit_calculator.dart';

class ProfitScreen extends StatefulWidget {
  const ProfitScreen({super.key});

  @override
  State<ProfitScreen> createState() => _ProfitScreenState();
}

class _ProfitScreenState extends State<ProfitScreen> {
  final TextEditingController _acresController = TextEditingController();

  String selectedCrop = "Paddy";

  Map<String, double>? result;

  /// 🌾 Crop + Telugu Mapping
  final Map<String, String> cropNames = {
    "Paddy": "వరి",
    "Tomato": "టమోటా",
    "Cotton": "పత్తి",
    "Maize": "మొక్కజొన్న",
  };

  void calculateProfit() {
    final acres = double.tryParse(_acresController.text);

    if (acres == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid acres")),
      );
      return;
    }

    final output = ProfitCalculator.calculate(selectedCrop, acres);

    setState(() {
      result = output;
    });
  }

  @override
  void dispose() {
    _acresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profit Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// SELECT CROP
            const Text("Select Crop / పంటను ఎంచుకోండి"),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedCrop,
              items: cropNames.entries.map((entry) {
                return DropdownMenuItem(
                  value: entry.key,
                  child: Text("${entry.key} (${entry.value})"),
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

            const SizedBox(height: 20),

            /// ACRES INPUT
            const Text("Enter Land Area (acres) / భూమి పరిమాణం"),
            const SizedBox(height: 8),

            TextField(
              controller: _acresController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "e.g. 2.5",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateProfit,
                child: const Text("Calculate Profit / లాభం లెక్కించు"),
              ),
            ),

            const SizedBox(height: 30),

            /// RESULT
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

                    Text("Yield / దిగుబడి: ${result!['yield']!.toStringAsFixed(0)} kg"),
                    Text("Income / ఆదాయం: ₹${result!['income']!.toStringAsFixed(0)}"),
                    Text("Cost / ఖర్చు: ₹${result!['cost']!.toStringAsFixed(0)}"),

                    const Divider(),

                    Text(
                      "Profit / లాభం: ₹${result!['profit']!.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: result!['profit']! >= 0
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}