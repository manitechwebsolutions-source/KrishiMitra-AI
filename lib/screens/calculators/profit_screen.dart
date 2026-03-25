import 'package:flutter/material.dart';
import 'package:krishimitra_ai/utils/profit_calculator.dart';

class ProfitScreen extends StatefulWidget {
  const ProfitScreen({super.key});

  @override
  State<ProfitScreen> createState() => _ProfitScreenState();
}

class _ProfitScreenState extends State<ProfitScreen> {
  final TextEditingController acresController = TextEditingController();
  final TextEditingController yieldController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final TextEditingController seedController = TextEditingController();
  final TextEditingController fertilizerController = TextEditingController();
  final TextEditingController laborController = TextEditingController();
  final TextEditingController irrigationController = TextEditingController();

  String selectedCrop = "Paddy";

  /// 🌾 Crop + Telugu Mapping
  final Map<String, String> cropNames = {
    "Paddy": "వరి",
    "Tomato": "టమోటా",
    "Cotton": "పత్తి",
    "Maize": "మొక్కజొన్న",
  };

  void calculateProfit() {
    final acres = double.tryParse(acresController.text);
    final yieldKinta = double.tryParse(yieldController.text);
    final pricePerKg = double.tryParse(priceController.text);

    final seed = double.tryParse(seedController.text) ?? 0;
    final fert = double.tryParse(fertilizerController.text) ?? 0;
    final labor = double.tryParse(laborController.text) ?? 0;
    final irrigation = double.tryParse(irrigationController.text) ?? 0;

    if (acres == null || yieldKinta == null || pricePerKg == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Enter valid inputs / సరైన వివరాలు ఇవ్వండి")),
      );
      return;
    }

    final output = ProfitCalculator.calculate(
      crop: selectedCrop,
      acres: acres,
      yieldPerAcreKinta: yieldKinta,
      marketPricePerKg: pricePerKg,
      seedCostPerAcre: seed,
      fertilizerCostPerAcre: fert,
      laborCostPerAcre: labor,
      irrigationCostPerAcre: irrigation,
    );

    showResultDialog(output);
  }

  /// 🔥 ANIMATED POPUP
  void showResultDialog(Map<String, dynamic> result) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Result",
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🌿 Title
                    Center(
                      child: Text(
                        "Result / ఫలితం",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// 🌾 Yield Card
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Yield: ${result['yieldKinta'].toStringAsFixed(1)} Kinta "
                            "(${result['yieldKg'].toStringAsFixed(0)} kg)",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text("Revenue: ₹${result['revenue'].toStringAsFixed(0)}"),
                    Text("Cost: ₹${result['cost'].toStringAsFixed(0)}"),

                    const Divider(),

                    /// 💰 Profit Card
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: result['profit'] >= 0
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Profit: ₹${result['profit'].toStringAsFixed(0)}",
                        style: TextStyle(
                          color: result['profit'] >= 0
                              ? Colors.green.shade800
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text("ROI: ${result['roi'].toStringAsFixed(1)} %"),
                    Text("Margin: ${result['margin'].toStringAsFixed(1)} %"),

                    Text(
                        "MSP: ₹${(result['msp'] * 100).toStringAsFixed(0)} / Kinta"),

                    Text(
                        "Break-even: ₹${result['breakEvenPrice'].toStringAsFixed(2)} / kg"),

                    Text(
                        "Cost per kg: ₹${result['costPerKg'].toStringAsFixed(2)}"),

                    Text(
                        "Profit per acre: ₹${result['profitPerAcre'].toStringAsFixed(0)}"),

                    const SizedBox(height: 12),

                    /// 🧠 Insights
                    Text(
                      "Insights / సూచనలు",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),

                    const SizedBox(height: 6),

                    ...result['insights'].map<Widget>((insight) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text("• $insight"),
                      );
                    }).toList(),

                    const SizedBox(height: 15),

                    /// ❌ Close Button
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close / మూసివేయి"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },

      /// ✨ Animation
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: Curves.easeOutBack.transform(animation.value),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
    );
  }

  Widget inputField(
      String label, String telugu, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label / $telugu"),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter value",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  void dispose() {
    acresController.dispose();
    yieldController.dispose();
    priceController.dispose();
    seedController.dispose();
    fertilizerController.dispose();
    laborController.dispose();
    irrigationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profit Calculator / లాభాల లెక్కింపు"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

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

            inputField("Land (acres)", "భూమి (ఎకరాలు)", acresController),
            inputField("Yield per acre (Kinta)", "ఎకరానికి క్వింటాళ్లు", yieldController),
            inputField("Market price (₹/kg)", "మార్కెట్ ధర", priceController),

            const Divider(),

            const Text("Cost Details / ఖర్చు వివరాలు",
                style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            inputField("Seed cost", "విత్తన ఖర్చు", seedController),
            inputField("Fertilizer cost", "ఎరువుల ఖర్చు", fertilizerController),
            inputField("Labor cost", "కూలీ ఖర్చు", laborController),
            inputField("Irrigation cost", "పారుదల ఖర్చు", irrigationController),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateProfit,
                child: const Text("Calculate / లెక్కించు"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}