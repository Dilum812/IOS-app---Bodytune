//
//  OnboardingView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-10.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var showMainApp = false
    
    var body: some View {
        if showMainApp {
            MainAppCoordinator()
        } else {
            TabView(selection: $currentPage) {
                OnboardingScreen1(
                    currentPage: $currentPage,
                    showMainApp: $showMainApp
                )
                .tag(0)
                
                OnboardingScreen2(
                    currentPage: $currentPage,
                    showMainApp: $showMainApp
                )
                .tag(1)
                
                OnboardingScreen3(
                    currentPage: $currentPage,
                    showMainApp: $showMainApp
                )
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
        }
    }
}

struct OnboardingScreen1: View {
    @Binding var currentPage: Int
    @Binding var showMainApp: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Black background
                Color.black
                    .ignoresSafeArea()
                
                // Full screen hero image
                Image("on1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .ignoresSafeArea(.all, edges: .top)
                
                // Content overlay at bottom
                VStack {
                    Spacer()
                    
                    // Content grouped together near bottom
                    VStack(spacing: 18) {
                        // App icon
                        Image("app icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                        
                        // Title
                        VStack(spacing: 4) {
                            Text("Welcome to Your")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Productive Journey")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        // Subtitle
                        Text("Track fitness in one simple app.")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        
                        // Progress indicator
                        HStack(spacing: 6) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.blue)
                                .frame(width: 20, height: 4)
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 20, height: 4)
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 20, height: 4)
                        }
                        .padding(.bottom, 8)
                    }
                    
                    // Buttons at bottom
                    VStack(spacing: 16) {
                        // Next button
                        Button(action: {
                            withAnimation {
                                currentPage = 1
                            }
                        }) {
                            Text("Next")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(Color.blue)
                                .cornerRadius(26)
                        }
                        .padding(.horizontal, 24)
                        
                        // Skip button
                        Button(action: {
                            showMainApp = true
                        }) {
                            Text("Skip")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 20)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.0),
                            Color.black.opacity(0.8),
                            Color.black
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
    }
}

struct OnboardingScreen2: View {
    @Binding var currentPage: Int
    @Binding var showMainApp: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Black background
                Color.black
                    .ignoresSafeArea()
                
                // Full screen hero image
                Image("on2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .ignoresSafeArea(.all, edges: .top)
                
                // Content overlay at bottom
                VStack {
                    Spacer()
                    
                    // Content grouped together near bottom
                    VStack(spacing: 18) {
                        // App icon
                        Image("app icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                        
                        // Title
                        VStack(spacing: 4) {
                            Text("Smarter Tracking,")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Better Results")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        // Subtitle
                        Text("Log meals, runs, and BMI easily.")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        
                        // Progress indicator
                        HStack(spacing: 6) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 20, height: 4)
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.blue)
                                .frame(width: 20, height: 4)
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 20, height: 4)
                        }
                        .padding(.bottom, 8)
                    }
                    
                    // Buttons at bottom
                    VStack(spacing: 16) {
                        // Next button
                        Button(action: {
                            withAnimation {
                                currentPage = 2
                            }
                        }) {
                            Text("Next")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(Color.blue)
                                .cornerRadius(26)
                        }
                        .padding(.horizontal, 24)
                        
                        // Skip button
                        Button(action: {
                            showMainApp = true
                        }) {
                            Text("Skip")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 20)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.0),
                            Color.black.opacity(0.8),
                            Color.black
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
    }
}

struct OnboardingScreen3: View {
    @Binding var currentPage: Int
    @Binding var showMainApp: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Black background
                Color.black
                    .ignoresSafeArea()
                
                // Full screen hero image
                Image("on3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .ignoresSafeArea(.all, edges: .top)
                
                // Content overlay at bottom
                VStack {
                    Spacer()
                    
                    // Content grouped together near bottom
                    VStack(spacing: 18) {
                        // App icon
                        Image("app icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                        
                        // Title
                        VStack(spacing: 4) {
                            Text("Stay Consistent &")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Motivated")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        // Subtitle
                        Text("Set goals and hit milestones.")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        
                        // Progress indicator
                        HStack(spacing: 6) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 20, height: 4)
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 20, height: 4)
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.blue)
                                .frame(width: 20, height: 4)
                        }
                        .padding(.bottom, 8)
                    }
                    
                    // Buttons at bottom
                    VStack(spacing: 16) {
                        // Get Started button (final screen)
                        Button(action: {
                            showMainApp = true
                        }) {
                            Text("Get Started")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(Color.blue)
                                .cornerRadius(26)
                        }
                        .padding(.horizontal, 24)
                        
                        // Skip button
                        Button(action: {
                            showMainApp = true
                        }) {
                            Text("Skip")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 20)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.0),
                            Color.black.opacity(0.8),
                            Color.black
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
    }
}

#Preview {
    OnboardingView()
}
