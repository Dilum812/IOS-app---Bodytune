# BodyTune - Fitness & Health Tracker

## Overview
BodyTune is a comprehensive iOS fitness and health tracking application designed to help users monitor their fitness journey, track nutrition, and maintain an active lifestyle. The app integrates with HealthKit for activity tracking and Firebase for user authentication and data storage.

## Features

### 🏠 Home Dashboard
- View daily activity summary
- Track steps, calories burned, and active minutes
- Quick access to recent workouts and meal logs

### 🍽️ Nutrition Tracking
- Log meals and track calorie intake
- Sri Lankan food database integration
- Daily nutrition breakdown (carbs, protein, fats)

### 🏃‍♂️ Activity Tracking
- Step counter with daily goals
- Workout tracking with various exercise types
- Integration with Apple HealthKit

### 💪 Training
- Workout library with exercise demonstrations
- Custom workout plans
- Progress tracking and history

### 📊 Health Metrics
- BMI calculator
- Weight tracking
- Health insights and trends

## Technical Stack
- **Frontend**: SwiftUI
- **Backend**: Firebase (Authentication, Firestore)
- **Health Integration**: HealthKit
- **Authentication**: Google Sign-In, Email/Password

## Getting Started

### Prerequisites
- Xcode 13.0 or later
- iOS 15.0 or later
- CocoaPods (for dependency management)
- Firebase account (for backend services)

### Installation
1. Clone the repository
2. Install dependencies using `pod install`
3. Open `IOS app.xcworkspace` in Xcode
4. Add your `GoogleService-Info.plist` to the project
5. Build and run the project

## Project Structure
- **Views**: Contains all the SwiftUI views
- **Managers**: Handles business logic and data management
  - [FirebaseAuthManager.swift](cci:7://file:///Users/dilumdissanayake/IOS%20App%20MADD/Users/dilumdissanayake/IOS%20App%20MADD/IOS%20app/IOS%20app/FirebaseAuthManager.swift:0:0-0:0): Authentication logic
  - [FirestoreManager.swift](cci:7://file:///Users/dilumdissanayake/IOS%20App%20MADD/Users/dilumdissanayake/IOS%20App%20MADD/IOS%20app/IOS%20app/FirestoreManager.swift:0:0-0:0): Database operations
  - [HealthKitManager.swift](cci:7://file:///Users/dilumdissanayake/IOS%20App%20MADD/Users/dilumdissanayake/IOS%20App%20MADD/IOS%20app/IOS%20app/HealthKitManager.swift:0:0-0:0): Health data access
  - [WorkoutManager.swift](cci:7://file:///Users/dilumdissanayake/IOS%20App%20MADD/Users/dilumdissanayake/IOS%20App%20MADD/IOS%20app/IOS%20app/WorkoutManager.swift:0:0-0:0): Workout session management
- **Models**: Data models and structures

## Dependencies
- Firebase/Auth
- Firebase/Firestore
- GoogleSignIn
- HealthKit

## Contributing
Contributions are welcome! Please follow the standard fork and pull request workflow.

## Support
For support, please open an issue in the repository or contact the maintainers.
