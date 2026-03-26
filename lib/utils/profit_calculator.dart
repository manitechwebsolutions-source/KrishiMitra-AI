class UnitConverter {
  static double kintaToKg(double kinta) => kinta * 100;
  static double kgToKinta(double kg) => kg / 100;
}

class ProfitCalculator {
  static Map<String, dynamic> calculate({
    required String crop,
    required double acres,

    /// 🌾 Input in Quintal
    required double yieldPerAcreKinta,

    required double marketPricePerKg,

    /// 💸 Costs
    required double seedCostPerAcre,
    required double fertilizerCostPerAcre,
    required double laborCostPerAcre,
    required double irrigationCostPerAcre,
    double miscCostPerAcre = 0,
  }) {

    /// 🌾 MSP (₹ per Quintal)
    final Map<String, double> mspRates = {
      "Paddy": 2183,
      "Wheat": 2275,
      "Maize": 2090,
      "Cotton": 6620,
      "Gram": 5440,
      "Mustard": 5650,
    };

    /// Convert MSP → ₹/kg
    double msp = mspRates.containsKey(crop)
        ? mspRates[crop]! / 100
        : 0;

    /// 🌶️ Volatile Crops
    final List<String> volatileCrops = [
      "Tomato",
      "Onion",
      "Potato",
      "Chilli",
      "Capsicum",
    ];

    bool isVolatile = volatileCrops.contains(crop);

    /// 🔁 Convert Kinta → KG
    double yieldPerAcreKg = UnitConverter.kintaToKg(yieldPerAcreKinta);

    /// 🌾 Total Yield
    double totalYieldKg = yieldPerAcreKg * acres;
    double totalYieldKinta = UnitConverter.kgToKinta(totalYieldKg);

    /// 💵 Revenue (REAL market price)
    double revenue = totalYieldKg * marketPricePerKg;

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
    double margin = revenue > 0 ? (profit / revenue) * 100 : 0;

    /// 🧮 Cost per kg
    double costPerKg =
    totalYieldKg > 0 ? totalCost / totalYieldKg : 0;

    /// ⚖️ Break-even price
    double breakEvenPrice =
    totalYieldKg > 0 ? totalCost / totalYieldKg : 0;

    /// 🌾 Profit per acre
    double profitPerAcre =
    acres > 0 ? profit / acres : 0;

    /// 🧠 Insights
    List<String> insights = [];

    const double epsilon = 0.01;

    /// 📉 Loss
    if (profit < 0) {
      insights.add(
          "You are making a loss. Reduce costs or wait for better price.");
    }

    /// 📊 ROI
    if (roi < 20) {
      insights.add(
          "Low ROI. Improve yield or reduce input costs.");
    }

    /// ⚖️ Break-even check
    if (marketPricePerKg < breakEvenPrice) {
      insights.add(
          "Market price is below break-even. Selling now may cause loss.");
    }

    /// 🌾 MSP comparison (FIXED with epsilon)
    if (msp > 0 && marketPricePerKg < msp - epsilon) {
      insights.add(
          "Market price is below MSP. Consider government procurement.");
    } else if (msp > 0 &&
        (marketPricePerKg - msp).abs() <= epsilon) {
      insights.add(
          "Market price is approximately equal to MSP.");
    }

    /// 🌶️ Volatility
    if (isVolatile) {
      insights.add(
          "This crop has high price volatility. Timing is very important.");
    }

    /// 💸 Fertilizer warning
    if (fertilizerCostPerAcre > seedCostPerAcre * 2) {
      insights.add(
          "Fertilizer cost is high. Try optimizing usage.");
    }

    /// 🌾 Yield check
    if (yieldPerAcreKinta < 10) {
      insights.add(
          "Yield per acre seems low. Check farming practices.");
    }

    /// 🚀 High profit
    if (profit > 0 && roi > 50) {
      insights.add("Excellent profitability. Great job 👍");
    }

    /// ✅ Final Output
    return {
      "yieldKg": totalYieldKg,
      "yieldKinta": totalYieldKinta,
      "revenue": revenue,
      "cost": totalCost,
      "profit": profit,
      "roi": roi,
      "margin": margin,
      "breakEvenPrice": breakEvenPrice,
      "msp": msp,
      "costPerKg": costPerKg,
      "profitPerAcre": profitPerAcre,
      "isVolatile": isVolatile,
      "insights": insights,
    };
  }
}