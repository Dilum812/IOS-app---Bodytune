//
//  UserProfileSetupView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-11.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct UserProfileSetupView: View {
    @StateObject private var firestoreManager = FirestoreManager()
    @State private var selectedGender: Gender = .male
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var age: String = ""
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @Binding var isProfileComplete: Bool
    
    enum Gender: String, CaseIterable {
        case male = "Male"
        case female = "Female"
        case other = "Other"
        
        var icon: String {
            switch self {
            case .male: return "person"
            case .female: return "person.fill"
            case .other: return "person.2"
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Black background
                Color.black
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        Spacer(minLength: 60)
                        
                        // Logo and Title
                        VStack(spacing: 20) {
                            Image(systemName: "figure.run.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.blue)
                            
                            Text("Tell Us About Yourself")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Your info helps us create the perfect plan for you.")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        
                        // Gender Selection
                        VStack(spacing: 15) {
                            HStack(spacing: 15) {
                                ForEach(Gender.allCases, id: \.self) { gender in
                                    Button(action: {
                                        selectedGender = gender
                                    }) {
                                        VStack(spacing: 8) {
                                            Image(systemName: gender.icon)
                                                .font(.system(size: 24))
                                                .foregroundColor(selectedGender == gender ? .white : .gray)
                                            
                                            Text(gender.rawValue)
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(selectedGender == gender ? .white : .gray)
                                        }
                                        .frame(width: 100, height: 80)
                                        .background(selectedGender == gender ? Color.blue : Color.gray.opacity(0.2))
                                        .cornerRadius(16)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        // Input Fields
                        VStack(spacing: 20) {
                            // Height Input
                            HStack {
                                Image(systemName: "ruler")
                                    .foregroundColor(.blue)
                                    .frame(width: 24)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Height (cm)")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.white)
                                    
                                    TextField("Enter your height", text: $height)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16))
                                        .keyboardType(.numberPad)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(16)
                            .padding(.horizontal, 24)
                            
                            // Weight Input
                            HStack {
                                Image(systemName: "scalemass")
                                    .foregroundColor(.blue)
                                    .frame(width: 24)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Weight (kg)")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.white)
                                    
                                    TextField("Enter your weight", text: $weight)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16))
                                        .keyboardType(.decimalPad)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(16)
                            .padding(.horizontal, 24)
                            
                            // Age Input
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.blue)
                                    .frame(width: 24)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Age (yrs)")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.white)
                                    
                                    TextField("Enter your age", text: $age)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16))
                                        .keyboardType(.numberPad)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(16)
                            .padding(.horizontal, 24)
                        }
                        
                        // Privacy Notice
                        Text("*Your data is private and only used to personalize your BodyTune experience.")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        // Continue Button
                        Button(action: {
                            saveUserProfile()
                        }) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(0.8)
                                } else {
                                    Text("Continue")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(isFormValid ? Color.blue : Color.gray.opacity(0.3))
                            .cornerRadius(26)
                        }
                        .disabled(!isFormValid || isLoading)
                        .padding(.horizontal, 24)
                        
                        // Skip Button
                        Button(action: {
                            isProfileComplete = true
                        }) {
                            Text("Skip for now")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom, 40)
                        
                        Spacer()
                    }
                }
            }
        }
        .alert("Profile Setup", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    // MARK: - Computed Properties
    private var isFormValid: Bool {
        !height.isEmpty && !weight.isEmpty && !age.isEmpty
    }
    
    // MARK: - Functions
    private func saveUserProfile() {
        guard let user = Auth.auth().currentUser else {
            showError("No authenticated user found")
            return
        }
        
        guard let heightValue = Double(height),
              let weightValue = Double(weight),
              let ageValue = Int(age) else {
            showError("Please enter valid numbers for height, weight, and age")
            return
        }
        
        isLoading = true
        
        let profileData: [String: Any] = [
            "gender": selectedGender.rawValue,
            "height": heightValue,
            "weight": weightValue,
            "age": ageValue,
            "profileCompleted": true,
            "profileCompletedAt": Timestamp(),
            "updatedAt": Timestamp()
        ]
        
        firestoreManager.updateDocument(
            collection: "users",
            documentId: user.uid,
            data: profileData
        ) { result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success:
                    print("✅ User profile saved successfully")
                    isProfileComplete = true
                case .failure(let error):
                    showError("Failed to save profile: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func showError(_ message: String) {
        alertMessage = message
        showAlert = true
    }
}

#Preview {
    UserProfileSetupView(isProfileComplete: .constant(false))
}
