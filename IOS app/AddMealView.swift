//
//  AddMealView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-14.
//

import SwiftUI

struct AddMealView: View {
    @Environment(\.dismiss) private var dismiss
    private let foodDatabase = SriLankanFoodDatabase.shared
    @State private var searchText = ""
    @State private var selectedFood: FoodItem?
    @State private var quantity: Double = 100
    @State private var selectedMealType: MealType = .breakfast
    
    let mealType: MealType
    let onAddMeal: (FoodItem, Double) -> Void
    
    var filteredFoods: [FoodItem] {
        foodDatabase.searchFoods(query: searchText)
    }
    
    var body: some View {
        ZStack {
            // Background with food image effect
            backgroundView
            
            VStack(spacing: 0) {
                // Header
                headerView
                    .padding(.top, 50)
                
                // Search Bar
                searchBarView
                
                if let selectedFood = selectedFood {
                    // Selected Food Details
                    selectedFoodView(food: selectedFood)
                    
                    // Meal Type Selection
                    mealTypeSelection
                        .padding(.top, 20)
                    
                    // Done Button
                    doneButton
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                } else {
                    // Food List
                    foodListView
                }
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    private var backgroundView: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if selectedFood != nil {
                // Food background image effect
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.orange.opacity(0.3),
                        Color.red.opacity(0.2),
                        Color.black
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                if selectedFood != nil {
                    selectedFood = nil
                } else {
                    dismiss()
                }
            }) {
                Image(systemName: selectedFood != nil ? "chevron.left" : "xmark")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.medium)
            }
            
            Text("Add Meal")
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
        .padding(.horizontal, 20)
    }
    
    private var searchBarView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .font(.system(size: 16))
            
            TextField("Grilled Chicken Breast", text: $searchText)
                .font(.system(size: 16))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
        )
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    private var foodListView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(filteredFoods, id: \.id) { food in
                    foodItemRow(food: food)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }
    
    private func foodItemRow(food: FoodItem) -> some View {
        Button(action: {
            selectedFood = food
            searchText = food.name
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(food.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    Text("\(food.caloriesPer100g) kcal per 100g")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Text(food.category.rawValue)
                        .font(.system(size: 12))
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func selectedFoodView(food: FoodItem) -> some View {
        VStack(spacing: 20) {
                // Food Image Placeholder (with fire effect background)
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.orange, Color.red]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 200)
                    
                    // Food icon or placeholder
                    Image(systemName: "fork.knife")
                        .font(.system(size: 60))
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
            
            // Food Details Card
            VStack(alignment: .leading, spacing: 20) {
                Text(food.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Text("\(Int(Double(food.caloriesPer100g) * quantity / 100)) kcal")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                
                // Macros
                VStack(spacing: 12) {
                    macroRow(label: "Protein", value: food.protein * quantity / 100, color: .blue)
                    macroRow(label: "Carbs", value: food.carbs * quantity / 100, color: .green)
                    macroRow(label: "Fat", value: food.fat * quantity / 100, color: .orange)
                }
                
                // Quantity Selector
                HStack {
                    Button(action: {
                        if quantity > 50 {
                            quantity -= 50
                        }
                    }) {
                        Image(systemName: "minus")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                            .frame(width: 40, height: 40)
                            .background(Circle().fill(Color.gray.opacity(0.3)))
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("\(Int(quantity))")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        Menu {
                            Button("50g") { quantity = 50 }
                            Button("100g") { quantity = 100 }
                            Button("150g") { quantity = 150 }
                            Button("200g") { quantity = 200 }
                            Button("250g") { quantity = 250 }
                        } label: {
                            HStack {
                                Text("100g")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.gray)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        quantity += 50
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                            .frame(width: 40, height: 40)
                            .background(Circle().fill(Color.gray.opacity(0.3)))
                    }
                }
                .padding(.top, 10)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.15))
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }
    
    private func macroRow(label: String, value: Double, color: Color) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(String(format: "%.1fg", value))
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
            
            Rectangle()
                .fill(color)
                .frame(width: 60, height: 4)
                .cornerRadius(2)
        }
    }
    
    private var mealTypeSelection: some View {
        HStack(spacing: 12) {
            ForEach(MealType.allCases, id: \.self) { type in
                Button(action: {
                    selectedMealType = type
                }) {
                    Text(type.rawValue)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(selectedMealType == type ? .white : .gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(selectedMealType == type ? Color.blue : Color.clear)
                        )
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    private var doneButton: some View {
        Button(action: {
            if let food = selectedFood {
                onAddMeal(food, quantity)
                dismiss()
            }
        }) {
            HStack {
                Text("Done")
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
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    AddMealView(mealType: .breakfast) { food, quantity in
        print("Added \(food.name) - \(quantity)g")
    }
}
