//
//  AuthTestView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-11.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AuthTestView: View {
    @StateObject private var authManager = FirebaseAuthManager()
    @State private var testResults: [String] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Firebase Authentication Test")
                    .font(.title)
                    .padding()
                
                // Current Auth Status
                VStack(alignment: .leading, spacing: 10) {
                    Text("Current Status:")
                        .font(.headline)
                    
                    Text("Signed In: \(authManager.isSignedIn ? "✅ Yes" : "❌ No")")
                    Text("User: \(authManager.userDisplayName)")
                    Text("Email: \(authManager.userEmail)")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Test Results
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Test Results:")
                            .font(.headline)
                        
                        ForEach(testResults, id: \.self) { result in
                            Text(result)
                                .font(.caption)
                                .foregroundColor(result.contains("✅") ? .green : result.contains("❌") ? .red : .blue)
                        }
                    }
                }
                .frame(height: 200)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Action Buttons
                VStack(spacing: 15) {
                    Button("Test Firebase Connection") {
                        testFirebaseConnection()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Test Google Sign-In") {
                        authManager.signInWithGoogle()
                    }
                    .buttonStyle(.bordered)
                    
                    if authManager.isSignedIn {
                        Button("Sign Out") {
                            authManager.signOut()
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(.red)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Auth Test")
        }
    }
    
    private func testFirebaseConnection() {
        testResults.append("🔄 Testing Firebase connection...")
        
        // Test 1: Check if Firebase is configured
        if FirebaseApp.app() != nil {
            testResults.append("✅ Firebase is configured")
        } else {
            testResults.append("❌ Firebase not configured")
            return
        }
        
        // Test 2: Check Auth instance
        let auth = Auth.auth()
        testResults.append("✅ Firebase Auth instance created")
        
        // Test 3: Check current user
        if let user = auth.currentUser {
            testResults.append("✅ Current user: \(user.email ?? "No email")")
        } else {
            testResults.append("ℹ️ No current user (not signed in)")
        }
        
        // Test 4: Test anonymous sign-in (to verify Auth works)
        auth.signInAnonymously { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    testResults.append("❌ Anonymous sign-in failed: \(error.localizedDescription)")
                } else {
                    testResults.append("✅ Anonymous sign-in successful")
                    // Sign out immediately
                    try? auth.signOut()
                    testResults.append("ℹ️ Signed out from anonymous session")
                }
            }
        }
    }
}

#Preview {
    AuthTestView()
}
