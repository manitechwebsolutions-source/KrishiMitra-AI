class ProfitCalculator {
  static Map<String, double> calculate(String crop, double acres) {
    double yieldPerAcre = 0; // kg
    double pricePerKg = 0;   // ₹
    double costPerAcre = 0;  // ₹

    switch (crop) {
      case "Paddy":
        yieldPerAcre = 2500;
        pricePerKg = 20;
        costPerAcre = 15000;
        break;

      case "Tomato":
        yieldPerAcre = 3000;
        pricePerKg = 15;
        costPerAcre = 20000;
        break;

      case "Cotton":
        yieldPerAcre = 2000;
        pricePerKg = 60;
        costPerAcre = 18000;
        break;

      case "Maize":
        yieldPerAcre = 2800;
        pricePerKg = 18;
        costPerAcre = 14000;
        break;
    }

    double totalYield = yieldPerAcre * acres;
    double totalIncome = totalYield * pricePerKg;
    double totalCost = costPerAcre * acres;
    double profit = totalIncome - totalCost;

    return {
      "yield": totalYield,
      "income": totalIncome,
      "cost": totalCost,
      "profit": profit,
    };
  }
}