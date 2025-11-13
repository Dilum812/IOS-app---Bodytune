//
//  MainAppCoordinator.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-11.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct MainAppCoordinator: View {
    @StateObject private var authManager = FirebaseAuthManager()
    
    var body: some View {
        Group {
            if !authManager.isSignedIn {
                // Show authentication screen
                AuthenticationView()
            } else {
                // Show main BodyTune app after authentication
                MainTabView()
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.5)
                
                Text("Loading...")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    MainAppCoordinator()
}
