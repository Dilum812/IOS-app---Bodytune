//
//  BodyTuneDashboardView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-14.
//

import SwiftUI
import Foundation

struct BodyTuneDashboardView: View {
    @StateObject private var authManager = FirebaseAuthManager()
    @State private var loginDate = Date() // Track when user logged in
    @State private var selectedDay = Calendar.current.component(.weekday, from: Date()) - 1 // Login day selected by default
    @State private var currentGoal = 1850
    @State private var maxGoal = 2200
    @State private var showBMICalculator = false
    @State private var showCalorieTracker = false
    
    // Calculate current week dates based on today's date
    private var weekDates: [Date] {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let daysFromSunday = weekday - 1
        
        guard let startOfWeek = calendar.date(byAdding: .day, value: -daysFromSunday, to: today) else {
            return []
        }
        
        return (0..<7).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek)
        }
    }
    
    private var todayIndex: Int {
        Calendar.current.component(.weekday, from: Date()) - 1
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    headerView
                        .padding(.top, 10)
                    
                    // Weekly Calendar
                    weeklyCalendarView
                    
                    // Main Content Grid
                    mainContentGrid
                    
                    // Workouts Section
                    workoutsSection
                    
                    // Achievements Section
                    achievementsSection
                    
                    Spacer(minLength: 100) // Space for tab bar
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            // BodyTune Logo
            HStack(spacing: 8) {
                Image(systemName: "figure.run.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title2)
                
                Text("BODYTUNE")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // Profile Avatar
            Button(action: {}) {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                    )
            }
        }
    }
    
    private var weeklyCalendarView: some View {
        HStack(spacing: 12) {
            ForEach(0..<7) { index in
                let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                let calendar = Calendar.current
                let dateFormatter: DateFormatter = {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd"
                    return formatter
                }()
                
                let currentDate = weekDates.indices.contains(index) ? weekDates[index] : Date()
                let dateString = dateFormatter.string(from: currentDate)
                let isToday = index == todayIndex
                
                VStack(spacing: 4) {
                    Text(days[index])
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                    
                    Text(dateString)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(selectedDay == index ? .black : .white)
                        .frame(width: 32, height: 32)
                        .background(
                            Circle()
                                .fill(selectedDay == index ? Color.blue : Color.clear)
                        )
                }
                .onTapGesture {
                    selectedDay = index
                }
            }
        }
        .padding(.vertical, 10)
        .onAppear {
            // Auto-select today when view appears
            selectedDay = todayIndex
        }
    }
    
    private var mainContentGrid: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            // Daily Goal Card
            dailyGoalCard
            
            // Today's Plan Card
            todaysPlanCard
            
            // Quick Run Card
            quickRunCard
            
            // BMI Card
            bmiCard
        }
    }
    
    private var dailyGoalCard: some View {
        Button(action: {
            showCalorieTracker = true
        }) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                        .frame(width: 100, height: 100)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(currentGoal) / CGFloat(maxGoal))
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(-90))
                    
                    VStack(spacing: 2) {
                        Text("\(currentGoal)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("/ \(maxGoal)")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Text("Daily Goal")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
            }
            .frame(width: 135, height: 150)
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.1))
            )
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showCalorieTracker) {
            CalorieTrackerView()
        }
    }
    
    private var todaysPlanCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "dumbbell.fill")
                    .foregroundColor(.blue)
                    .font(.title2)
                
                Text("Today's Plan")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Full Body")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Workout")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("45 min • 12 exercises")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 135, height: 150)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
        )
    }
    
    private var quickRunCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Run")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
            
            HStack {
                Image(systemName: "figure.run")
                    .foregroundColor(.blue)
                    .font(.title)
                
                Spacer()
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("Start tracking")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.blue)
                    )
            }
        }
        .frame(height: 120)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
        )
    }
    
    private var bmiCard: some View {
        Button(action: {
            showBMICalculator = true
        }) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("BMI")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("Healthy Range")
                        .font(.system(size: 10))
                        .foregroundColor(.green)
                }
                
                Text("22.4")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                // BMI Progress Bar
                VStack {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 4)
                            .cornerRadius(2)
                        
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 60, height: 4)
                            .cornerRadius(2)
                    }
                }
            }
            .frame(height: 120)
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.1))
            )
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showBMICalculator) {
            BMICalculatorView()
        }
    }
    
    private var workoutsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Workouts")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            // Workout Card
            HStack {
                // Workout Image
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "figure.strengthtraining.traditional")
                            .foregroundColor(.white)
                            .font(.title)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Do 7 exercises today")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("Full body workout routine")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.1))
            )
        }
    }
    
    private var achievementsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Achievements")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            HStack(spacing: 16) {
                // 30 Days Achievement
                VStack(spacing: 8) {
                    Image(systemName: "medal.fill")
                        .foregroundColor(.blue)
                        .font(.title)
                    
                    Text("30 Days")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("28/30")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.1))
                )
                
                // Calories Achievement
                VStack(spacing: 8) {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                        .font(.title)
                    
                    Text("Calories")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("1.8k/2k")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.1))
                )
                
                // Workouts Achievement
                VStack(spacing: 8) {
                    Image(systemName: "figure.mixed.cardio")
                        .foregroundColor(.green)
                        .font(.title)
                    
                    Text("Workouts")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("12/15")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.1))
                )
            }
        }
    }
}

#Preview {
    BodyTuneDashboardView()
}
