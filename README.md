# KrishiMitra-AI
🌾 KrishiMitra AI

An Offline AI-Powered Agriculture Assistant built to support Indian farmers with crop disease detection, cultivation guidance, calculators, and multi-language support — completely free and usable without login.

🚀 Vision
KrishiMitra AI aims to provide intelligent, reliable, and offline agricultural support to farmers across India, especially in rural areas with limited internet connectivity.

🎯 Core Features

🌿 1. Instant Crop Disease Detection
Uses TensorFlow Lite model
Works completely offline
Predicts crop disease from leaf image
Displays step-by-step solution from inbuilt data

💬 2. AI Farming Guide (Offline Knowledge Base)
Step-by-step cultivation process
Crop calendar
Seasonal crop suggestions
Structured inbuilt agricultural data

🧪 3. Fertilizer Calculator
Based on crop type
Field size input (acres)
Soil type based recommendations

💰 4. Profit Calculator
Yield estimation
Market price input
Cost vs profit breakdown
🌦 5. Seasonal Crop Suggestions
Month-based logic
Region-based static data
Works without internet
🏛 6. Government Schemes
Inbuilt schemes data
Simplified explanation
No API dependency
🌍 7. Multi-Language Support
Telugu
Hindi
Tamil
Kannada
English
Expandable language architecture
🛠 Tech Stack
📱 Mobile Framework
Flutter (Dart)
🧠 Machine Learning
TensorFlow (Model Training)
TensorFlow Lite (Mobile inference)
📂 Data Storage
Local JSON files
Encrypted assets (optional)
🔐 Security
Flutter obfuscation
R8 / ProGuard enabled
Release build optimized
🏗 Architecture
Flutter App
   |
   |-- TFLite Model (Disease Detection)
   |-- Local JSON Data (Crop info, schemes, calendar)
   |-- Offline Calculators (Dart logic)
   |-- Intl Language Support
📦 Folder Structure
lib/
 ├── main.dart
 ├── screens/
 ├── services/
 ├── utils/
 ├── data/
assets/
 ├── model/
 ├── data/
 ├── lang/
 📲 How It Works
User opens app (no login required)
Selects feature (Disease Detection / Calculator / Guide)
ML model predicts disease (offline)
App fetches solution from inbuilt knowledge base
Displays simple step-by-step guidance
🔐 Privacy
No personal data collection
No login required
No cloud storage
No user tracking
Fully offline functionality
🎯 Target Users
Small & medium farmers
Rural areas with low connectivity
Multi-language communities
Beginners in farming
💡 Future Enhancements
Optional online weather updates
Market price integration
Voice input & output
Regional pest alerts
Smart irrigation suggestions
📜 License
This project is built to support the agricultural community and is free for educational and non-commercial use.
❤️ Mission
Empowering farmers with accessible AI tools to improve productivity, reduce crop loss, and increase profits — without requiring internet or technical knowledge.
