class UnitConverter {
  static double kintaToKg(double kinta) => kinta * 100;
  static double kgToKinta(double kg) => kg / 100;
}

class ProfitCalculator {
  static Map<String, dynamic> calculate({
    required String crop,
    required double acres,

    // 🌾 Input in KINTA (Quintal)
    required double yieldPerAcreKinta,

    required double marketPricePerKg,

    // 💸 Costs
    required double seedCostPerAcre,
    required double fertilizerCostPerAcre,
    required double laborCostPerAcre,
    required double irrigationCostPerAcre,
    double miscCostPerAcre = 0,
  }) {
    /// 🌾 MSP (₹/kg)
    final Map<String, double> mspRates = {
      "Paddy": 21.83,
      "Wheat": 22.75,
      "Cotton": 66.0,
      "Maize": 20.9,
    };

    double msp = mspRates[crop] ?? marketPricePerKg;

    /// 🔁 Convert Kinta → KG
    double yieldPerAcreKg = UnitConverter.kintaToKg(yieldPerAcreKinta);

    /// 💰 Choose better price
    double effectivePrice =
    marketPricePerKg < msp ? msp : marketPricePerKg;

    /// 🌾 Yield
    double totalYieldKg = yieldPerAcreKg * acres;
    double totalYieldKinta = UnitConverter.kgToKinta(totalYieldKg);

    /// 💵 Revenue
    double revenue = totalYieldKg * effectivePrice;

    /// 💸 Cost
    double totalCostPerAcre = seedCostPerAcre +
        fertilizerCostPerAcre +
        laborCostPerAcre +
        irrigationCostPerAcre +
        miscCostPerAcre;

    double totalCost = totalCostPerAcre * acres;

    /// 📊 Profit
    double profit = revenue - totalCost;

    /// 📈 Metrics
    double roi = totalCost > 0 ? (profit / totalCost) * 100 : 0;
    double profitMargin = revenue > 0 ? (profit / revenue) * 100 : 0;
    double breakEvenPrice =
    totalYieldKg > 0 ? totalCost / totalYieldKg : 0;

    /// ➕ Extra Metrics
    double costPerKg =
    totalYieldKg > 0 ? totalCost / totalYieldKg : 0;

    double profitPerAcre =
    acres > 0 ? profit / acres : 0;

    /// 🧠 Insights
    List<String> insights = [];

    if (marketPricePerKg < msp) {
      insights.add(
          "Market price is below MSP. Selling at MSP is safer.");
    }

    if (fertilizerCostPerAcre > seedCostPerAcre * 2) {
      insights.add(
          "High fertilizer cost detected. Consider optimizing usage.");
    }

    if (profit < 0) {
      insights.add(
          "You are in loss. Reduce costs or wait for better market price.");
    }

    if (roi > 50) {
      insights.add("Excellent ROI. This is a highly profitable crop.");
    }

    if (profitMargin < 20) {
      insights.add(
          "Low profit margin. Try increasing selling price or reducing costs.");
    }

    if (yieldPerAcreKinta < 10) {
      insights.add(
          "Yield per acre is low compared to typical AP/Telangana farming.");
    }

    return {
      "yieldKg": totalYieldKg,
      "yieldKinta": totalYieldKinta,
      "revenue": revenue,
      "cost": totalCost,
      "profit": profit,
      "roi": roi,
      "margin": profitMargin,
      "breakEvenPrice": breakEvenPrice,
      "msp": msp,
      "effectivePrice": effectivePrice,
      "costPerKg": costPerKg,
      "profitPerAcre": profitPerAcre,
      "insights": insights,
    };
  }
}