//
//  MainTabView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-14.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            BodyTuneDashboardView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .font(.system(size: 20))
                    Text("Home")
                        .font(.system(size: 10))
                }
                .tag(0)
            
            // Meals Tab
            MealsView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "fork.knife.circle.fill" : "fork.knife.circle")
                        .font(.system(size: 20))
                    Text("Meals")
                        .font(.system(size: 10))
                }
                .tag(1)
            
            // Run Tab
            RunView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "figure.run.circle.fill" : "figure.run.circle")
                        .font(.system(size: 20))
                    Text("Run")
                        .font(.system(size: 10))
                }
                .tag(2)
            
            // Train Tab
            TrainView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "dumbbell.fill" : "dumbbell")
                        .font(.system(size: 20))
                    Text("Train")
                        .font(.system(size: 10))
                }
                .tag(3)
            
            // BMI Tab
            BMIView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.crop.circle.fill" : "person.crop.circle")
                        .font(.system(size: 20))
                    Text("BMI")
                        .font(.system(size: 10))
                }
                .tag(4)
        }
        .accentColor(.blue)
        .preferredColorScheme(.dark)
    }
}

// Placeholder views for other tabs
struct MealsView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Meals")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text("Coming Soon")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct RunView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Run")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text("Coming Soon")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct TrainView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Train")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text("Coming Soon")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct BMIView: View {
    var body: some View {
        BMICalculatorTabView()
    }
}

#Preview {
    MainTabView()
}
