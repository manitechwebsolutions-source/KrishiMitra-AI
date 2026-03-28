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

  // Focus nodes for auto-scroll
  final FocusNode acresFocus = FocusNode();
  final FocusNode yieldFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final FocusNode seedFocus = FocusNode();
  final FocusNode fertilizerFocus = FocusNode();
  final FocusNode laborFocus = FocusNode();
  final FocusNode irrigationFocus = FocusNode();

  final ScrollController scrollController = ScrollController();

  String selectedCrop = "Paddy";

  final Map<String, String> cropNames = {
    "Paddy": "వరి",
    "Wheat": "గోధుమలు",
    "Maize": "మొక్కజొన్న",
    "Cotton": "పత్తి",
    "Gram": "సెనగలు",
    "Mustard": "ఆవాలు",
    "Tomato": "టమోటా",
    "Onion": "ఉల్లిపాయ",
    "Potato": "బంగాళాదుంప",
    "Chilli": "మిర్చి",
    "Capsicum": "క్యాప్సికమ్",
  };

  @override
  void initState() {
    super.initState();
    // Add listeners to auto-scroll when focus changes
    acresFocus.addListener(() => _scrollToFocus(acresFocus));
    yieldFocus.addListener(() => _scrollToFocus(yieldFocus));
    priceFocus.addListener(() => _scrollToFocus(priceFocus));
    seedFocus.addListener(() => _scrollToFocus(seedFocus));
    fertilizerFocus.addListener(() => _scrollToFocus(fertilizerFocus));
    laborFocus.addListener(() => _scrollToFocus(laborFocus));
    irrigationFocus.addListener(() => _scrollToFocus(irrigationFocus));
  }

  void _scrollToFocus(FocusNode focusNode) {
    if (focusNode.hasFocus) {
      // Wait for keyboard to appear
      Future.delayed(const Duration(milliseconds: 300), () {
        if (scrollController.hasClients) {
          // Get the position of the focused field
          final RenderBox? renderBox = focusNode.context?.findRenderObject() as RenderBox?;
          if (renderBox != null) {
            final position = renderBox.localToGlobal(Offset.zero);
            final screenHeight = MediaQuery.of(context).size.height;
            final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

            // Calculate offset to bring field above keyboard
            final offset = position.dy - (screenHeight - keyboardHeight) * 0.3;

            if (offset > 0) {
              scrollController.animateTo(
                scrollController.offset + offset,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          }
        }
      });
    }
  }

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
        const SnackBar(content: Text("Enter valid inputs / సరైన వివరాలు ఇవ్వండి")),
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

  void showResultDialog(Map<String, dynamic> result) {
    final theme = Theme.of(context);

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
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Center(
                      child: Text(
                        "Result / ఫలితం",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Volatility Tag
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isVolatile
                            ? Colors.orange.shade200
                            : theme.colorScheme.primary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isVolatile
                            ? "⚠️ High Price Volatility Crop"
                            : "✅ MSP Supported Crop (Stable)",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Yield
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.2),
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

                    /// Profit
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
                          const Text("Net Profit / నికర లాభం"),
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

                    Text("ROI: ${round2(result['roi'])} %"),
                    Text("Profit Margin: ${round2(result['margin'])} %"),

                    const SizedBox(height: 6),

                    if (result['msp'] > 0)
                      Text("MSP: ₹${round2(result['msp'])} / kg")
                    else
                      const Text("No MSP"),

                    Text("Break-even: ₹${round2(result['breakEvenPrice'])}"),
                    Text("Cost/kg: ₹${round2(result['costPerKg'])}"),
                    Text("Profit/Acre: ₹${round2(result['profitPerAcre'])}"),

                    const SizedBox(height: 12),

                    Text(
                      "Insights",
                      style: theme.textTheme.titleMedium,
                    ),

                    const SizedBox(height: 6),

                    if ((result['insights'] as List).isEmpty)
                      const Text("• No major issues"),

                    ...result['insights'].map<Widget>((insight) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text("• $insight"),
                      );
                    }).toList(),

                    const SizedBox(height: 15),

                    Center(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
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
          child: Opacity(opacity: animation.value, child: child),
        );
      },
    );
  }

  Widget inputField(String label, String telugu, TextEditingController controller, FocusNode focusNode) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label / $telugu", style: theme.textTheme.bodyMedium),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "Enter value",
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose all controllers
    acresController.dispose();
    yieldController.dispose();
    priceController.dispose();
    seedController.dispose();
    fertilizerController.dispose();
    laborController.dispose();
    irrigationController.dispose();

    // Dispose all focus nodes
    acresFocus.dispose();
    yieldFocus.dispose();
    priceFocus.dispose();
    seedFocus.dispose();
    fertilizerFocus.dispose();
    laborFocus.dispose();
    irrigationFocus.dispose();

    // Dispose scroll controller
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - appBarHeight - statusBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profit Calculator / లాభాల లెక్కింపు"),
        toolbarHeight: 56,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(), // Allow scrolling only when needed
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: availableHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Crop Selection
                    Text("Select Crop", style: theme.textTheme.titleMedium),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: selectedCrop,
                      items: cropNames.entries.map((entry) {
                        return DropdownMenuItem(
                          value: entry.key,
                          child: Text("${entry.key} (${entry.value})", style: const TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCrop = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Input Fields with FocusNodes
                    inputField("Land (acres)", "భూమి", acresController, acresFocus),
                    inputField("Yield per acre", "క్వింటాళ్లు", yieldController, yieldFocus),
                    inputField("Market price", "ధర", priceController, priceFocus),

                    const Divider(height: 8),

                    // Cost Details Section
                    Text("Cost Details", style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),

                    // Cost Fields with FocusNodes
                    inputField("Seed cost", "విత్తన", seedController, seedFocus),
                    inputField("Fertilizer cost", "ఎరువు", fertilizerController, fertilizerFocus),
                    inputField("Labor cost", "కూలీ", laborController, laborFocus),
                    inputField("Irrigation cost", "పారుదల", irrigationController, irrigationFocus),
                  ],
                ),

                // Calculate Button
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: calculateProfit,
                      child: const Text("Calculate", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}