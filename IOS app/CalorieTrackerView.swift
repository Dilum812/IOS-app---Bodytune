//
//  CalorieTrackerView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-14.
//

import SwiftUI

struct MealEntry {
    let id = UUID()
    let name: String
    let calories: Int
    let targetCalories: Int
    let mealType: MealType
    let color: Color
}

enum MealType: String, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snacks = "Snacks"
    
    var icon: String {
        switch self {
        case .breakfast: return "sun.max"
        case .lunch: return "sun.max.fill"
        case .dinner: return "moon"
        case .snacks: return "star"
        }
    }
    
    var color: Color {
        switch self {
        case .breakfast: return .blue
        case .lunch: return .purple
        case .dinner: return .blue
        case .snacks: return .purple
        }
    }
}

struct CalorieTrackerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showAddMeal = false
    @State private var selectedMealType: MealType = .breakfast
    @State private var totalCalories = 1467
    @State private var targetCalories = 2200
    @State private var caloriesLeft = 733
    
    @State private var meals: [MealEntry] = [
        MealEntry(name: "Breakfast", calories: 320, targetCalories: 500, mealType: .breakfast, color: .blue),
        MealEntry(name: "Lunch", calories: 450, targetCalories: 600, mealType: .lunch, color: .purple),
        MealEntry(name: "Dinner", calories: 380, targetCalories: 700, mealType: .dinner, color: .blue),
        MealEntry(name: "Snacks", calories: 200, targetCalories: 300, mealType: .snacks, color: .purple)
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                headerView
                    .padding(.top, 50)
                
                // Calorie Circle
                calorieCircleView
                
                // Meals Grid
                mealsGridView
                
                Spacer()
                
                // Add Meal Button
                addMealButton
                
                Spacer(minLength: 100)
            }
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea(.container, edges: .top)
        .fullScreenCover(isPresented: $showAddMeal) {
            AddMealView(mealType: selectedMealType) { foodItem, quantity in
                addMealEntry(foodItem: foodItem, quantity: quantity, mealType: selectedMealType)
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.medium)
            }
            
            Text("Calorie Tracker")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer()
            
            // Profile Avatar
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
    
    private var calorieCircleView: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 12)
                .frame(width: 200, height: 200)
            
            // Progress Circle
            Circle()
                .trim(from: 0, to: CGFloat(totalCalories) / CGFloat(targetCalories))
                .stroke(Color.green, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 1.0), value: totalCalories)
            
            // Center Content
            VStack(spacing: 4) {
                Text("\(caloriesLeft)")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                
                Text("kcal left")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 20)
    }
    
    private var mealsGridView: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            ForEach(meals, id: \.id) { meal in
                mealCard(meal: meal)
            }
        }
    }
    
    private func mealCard(meal: MealEntry) -> some View {
        Button(action: {
            selectedMealType = meal.mealType
            showAddMeal = true
        }) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: meal.mealType.icon)
                        .foregroundColor(meal.color)
                        .font(.title2)
                    
                    Text(meal.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
                Text("\(meal.calories)/\(meal.targetCalories) kcal")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                
                // Progress Bar
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 6)
                        .cornerRadius(3)
                    
                    Rectangle()
                        .fill(meal.color)
                        .frame(width: CGFloat(meal.calories) / CGFloat(meal.targetCalories) * 120, height: 6)
                        .cornerRadius(3)
                        .animation(.easeInOut(duration: 0.5), value: meal.calories)
                }
                .frame(width: 120)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 120)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.15))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var addMealButton: some View {
        Button(action: {
            selectedMealType = .breakfast
            showAddMeal = true
        }) {
            HStack {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .semibold))
                
                Text("Add Meal")
                    .font(.system(size: 18, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.blue)
            )
        }
    }
    
    private func addMealEntry(foodItem: FoodItem, quantity: Double, mealType: MealType) {
        let calories = Int(Double(foodItem.caloriesPer100g) * quantity / 100.0)
        
        // Update the corresponding meal
        if let index = meals.firstIndex(where: { $0.mealType == mealType }) {
            meals[index] = MealEntry(
                name: meals[index].name,
                calories: meals[index].calories + calories,
                targetCalories: meals[index].targetCalories,
                mealType: mealType,
                color: meals[index].color
            )
        }
        
        // Update totals
        totalCalories += calories
        caloriesLeft = targetCalories - totalCalories
    }
}

#Preview {
    CalorieTrackerView()
}
