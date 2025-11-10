//
//  AuthenticationView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-10.
//

import SwiftUI

struct AuthenticationView: View {
    @State private var isSignUp = true
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showMainApp = false
    
    var body: some View {
        if showMainApp {
            ContentView()
        } else {
            GeometryReader { geometry in
                ZStack {
                    // Black background
                    Color.black
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        Spacer()
                        
                        // App icon
                        Image("app icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .padding(.bottom, 24)
                        
                        // Title
                        Text("Welcome Back")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 8)
                        
                        // Subtitle
                        Text("Log in now to continue your BodyTune fitness journey.")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .padding(.bottom, 40)
                        
                        // Form fields
                        VStack(spacing: 16) {
                            // Email field
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                
                                TextField("Enter your email", text: $email)
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(12)
                            .padding(.horizontal, 24)
                            
                            // Password field
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                
                                SecureField(isSignUp ? "Create a password" : "Enter your password", text: $password)
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(12)
                            .padding(.horizontal, 24)
                            
                            // Confirm password field (only for sign up)
                            if isSignUp {
                                HStack {
                                    Image(systemName: "lock")
                                        .foregroundColor(.gray)
                                        .frame(width: 20)
                                    
                                    SecureField("Re-enter your password", text: $confirmPassword)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(12)
                                .padding(.horizontal, 24)
                            }
                        }
                        .padding(.bottom, 32)
                        
                        // Main action button
                        Button(action: {
                            // Handle sign in/up action
                            showMainApp = true
                        }) {
                            Text(isSignUp ? "Sign Up" : "Sign In")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(Color.blue)
                                .cornerRadius(26)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                        
                        // Divider
                        Text("or continue with")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                            .padding(.bottom, 24)
                        
                        // Google sign in button
                        Button(action: {
                            // Handle Google sign in
                            showMainApp = true
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "globe")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                                
                                Text("Continue with Google")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(26)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                        
                        // Toggle sign in/up
                        HStack {
                            Text(isSignUp ? "Already have an account?" : "Don't have an account?")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isSignUp.toggle()
                                    // Clear fields when switching
                                    email = ""
                                    password = ""
                                    confirmPassword = ""
                                }
                            }) {
                                Text(isSignUp ? "Sign In" : "Sign Up")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.bottom, 40)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
