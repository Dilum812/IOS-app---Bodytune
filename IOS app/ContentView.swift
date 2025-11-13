//
//  ContentView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-10.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authManager = FirebaseAuthManager()
    
    var body: some View {
        TabView {
            // Main App Content
            VStack {
                Image(systemName: "figure.run")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Welcome to BodyTune!")
                    .font(.title)
                
                if authManager.isSignedIn {
                    Text("Hello, \(authManager.userDisplayName)!")
                        .font(.headline)
                        .padding()
                    
                    Button("Sign Out") {
                        authManager.signOut()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            // Auth Test Tab
            AuthTestView()
                .tabItem {
                    Image(systemName: "person.badge.key")
                    Text("Auth Test")
                }
        }
    }
}

#Preview {
    ContentView()
}
