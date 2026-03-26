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

  /// 🌾 Expanded Crop List
  final Map<String, String> cropNames = {
    "Paddy": "వరి",
    "Wheat": "గోధుమలు",
    "Maize": "మొక్కజొన్న",
    "Cotton": "పత్తి",
    "Gram": "సెనగలు",
    "Mustard": "ఆవాలు",

    /// 🌶️ Volatile crops
    "Tomato": "టమోటా",
    "Onion": "ఉల్లిపాయ",
    "Potato": "బంగాళాదుంప",
    "Chilli": "మిర్చి",
    "Capsicum": "క్యాప్సికమ్",
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

  /// 🔥 UPDATED RESULT DIALOG WITH VOLATILITY
  void showResultDialog(Map<String, dynamic> result) {
    double round2(double v) => double.parse(v.toStringAsFixed(2));

    bool isVolatile = result['isVolatile'] ?? false;

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

                    const SizedBox(height: 10),

                    /// ⚠️ Volatility Tag
                    if (isVolatile)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "⚠️ High Price Volatility Crop",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "✅ MSP Supported Crop (Stable)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                    const SizedBox(height: 12),

                    /// 🌾 Yield
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Total Yield: ${round2(result['yieldKinta'])} Quintal "
                            "(${round2(result['yieldKg'])} kg)",
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text("Total Revenue: ₹${round2(result['revenue'])}"),
                    Text("Total Cost: ₹${round2(result['cost'])}"),

                    const Divider(),

                    /// 💰 Profit
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: result['profit'] >= 0
                            ? Colors.green.shade200
                            : Colors.red.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Net Profit / నికర లాభం",
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "₹${round2(result['profit'])}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: result['profit'] >= 0
                                  ? Colors.green.shade900
                                  : Colors.red.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                        "Return on Investment (ROI): ${round2(result['roi'])} %"),
                    Text(
                        "Profit Margin: ${round2(result['margin'])} %"),

                    const SizedBox(height: 6),

                    /// MSP Display (Smart)
                    if (result['msp'] > 0)
                      Text(
                          "Minimum Support Price (MSP): ₹${round2(result['msp'])} / kg "
                              "(₹${round2(result['msp'] * 100)} / Quintal)")
                    else
                      const Text("No MSP (Market-driven crop)"),

                    Text(
                        "Break-even Price: ₹${round2(result['breakEvenPrice'])} / kg"),
                    Text("Cost per kg: ₹${round2(result['costPerKg'])}"),
                    Text(
                        "Profit per Acre: ₹${round2(result['profitPerAcre'])}"),

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

                    if ((result['insights'] as List).isEmpty)
                      const Text("• No major issues detected. Good job 👍"),

                    ...result['insights'].map<Widget>((insight) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text("• $insight"),
                      );
                    }).toList(),

                    const SizedBox(height: 15),

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
            inputField("Yield per acre (Quintal)", "ఎకరానికి క్వింటాళ్లు", yieldController),
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