//
//  SplashScreenView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-10.
//

import SwiftUI
import FirebaseFirestore

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            OnboardingView()
        } else {
            GeometryReader { geometry in
                ZStack {
                    // Black background
                    Color.black
                        .ignoresSafeArea()
                    
                    // Logo image - perfectly centered in middle of screen
                    Image("Bodytune logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 460, height: 400)
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height / 2
                        )
                }
            }
            .onAppear {
                // Test Firestore connection
                testFirestoreConnection()
                
                // Auto-transition after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
    
    // MARK: - Firestore Connection Test
    private func testFirestoreConnection() {
        let db = Firestore.firestore()
        
        // Test 1: Write a test document
        let testData: [String: Any] = [
            "message": "Firebase connection test",
            "timestamp": Timestamp(),
            "app": "BodyTune iOS"
        ]
        
        db.collection("connection_test").addDocument(data: testData) { error in
            if let error = error {
                print("❌ Firestore WRITE failed: \(error.localizedDescription)")
            } else {
                print("✅ Firestore WRITE successful!")
                
                // Test 2: Read the test collection
                db.collection("connection_test").limit(to: 1).getDocuments { snapshot, error in
                    if let error = error {
                        print("❌ Firestore READ failed: \(error.localizedDescription)")
                    } else if let documents = snapshot?.documents, !documents.isEmpty {
                        print("✅ Firestore READ successful! Found \(documents.count) document(s)")
                        print("📊 Database connection is WORKING!")
                    } else {
                        print("⚠️ Firestore READ returned no documents")
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
