//
//  SriLankanFoodDatabase.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-14.
//

import Foundation
import Combine

struct FoodItem {
    let id = UUID()
    let name: String
    let caloriesPer100g: Int
    let protein: Double // grams per 100g
    let carbs: Double // grams per 100g
    let fat: Double // grams per 100g
    let category: FoodCategory
}

enum FoodCategory: String, CaseIterable {
    case rice = "Rice & Grains"
    case curry = "Curries"
    case meat = "Meat & Fish"
    case vegetables = "Vegetables"
    case snacks = "Snacks"
    case sweets = "Sweets"
    case beverages = "Beverages"
    case bread = "Bread & Roti"
}

class SriLankanFoodDatabase: ObservableObject {
    static let shared = SriLankanFoodDatabase()
    
    let foods: [FoodItem] = [
        // Rice & Grains
        FoodItem(name: "White Rice (Cooked)", caloriesPer100g: 130, protein: 2.7, carbs: 28.0, fat: 0.3, category: .rice),
        FoodItem(name: "Red Rice (Cooked)", caloriesPer100g: 111, protein: 2.3, carbs: 23.0, fat: 0.9, category: .rice),
        FoodItem(name: "Kottu Roti", caloriesPer100g: 165, protein: 8.5, carbs: 20.0, fat: 6.2, category: .rice),
        FoodItem(name: "Fried Rice", caloriesPer100g: 163, protein: 4.0, carbs: 25.0, fat: 5.5, category: .rice),
        FoodItem(name: "Biriyani", caloriesPer100g: 298, protein: 9.0, carbs: 35.0, fat: 13.0, category: .rice),
        FoodItem(name: "String Hoppers", caloriesPer100g: 355, protein: 8.5, carbs: 72.0, fat: 2.5, category: .rice),
        FoodItem(name: "Hoppers (Plain)", caloriesPer100g: 137, protein: 2.8, carbs: 28.0, fat: 1.2, category: .rice),
        FoodItem(name: "Egg Hopper", caloriesPer100g: 180, protein: 8.0, carbs: 28.0, fat: 4.5, category: .rice),
        
        // Curries
        FoodItem(name: "Chicken Curry", caloriesPer100g: 165, protein: 28.0, carbs: 0.0, fat: 3.6, category: .curry),
        FoodItem(name: "Fish Curry", caloriesPer100g: 128, protein: 20.0, carbs: 2.0, fat: 4.5, category: .curry),
        FoodItem(name: "Dhal Curry", caloriesPer100g: 116, protein: 9.0, carbs: 20.0, fat: 0.4, category: .curry),
        FoodItem(name: "Potato Curry", caloriesPer100g: 87, protein: 2.0, carbs: 20.0, fat: 0.1, category: .curry),
        FoodItem(name: "Coconut Sambol", caloriesPer100g: 354, protein: 3.3, carbs: 15.0, fat: 33.0, category: .curry),
        FoodItem(name: "Seeni Sambol", caloriesPer100g: 89, protein: 1.5, carbs: 22.0, fat: 0.2, category: .curry),
        FoodItem(name: "Beef Curry", caloriesPer100g: 250, protein: 26.0, carbs: 3.0, fat: 15.0, category: .curry),
        FoodItem(name: "Pork Curry", caloriesPer100g: 242, protein: 27.0, carbs: 2.0, fat: 14.0, category: .curry),
        
        // Meat & Fish
        FoodItem(name: "Grilled Chicken Breast", caloriesPer100g: 165, protein: 31.0, carbs: 0.0, fat: 3.6, category: .meat),
        FoodItem(name: "Fried Fish", caloriesPer100g: 206, protein: 20.0, carbs: 7.0, fat: 11.0, category: .meat),
        FoodItem(name: "Tuna (Canned)", caloriesPer100g: 132, protein: 30.0, carbs: 0.0, fat: 1.0, category: .meat),
        FoodItem(name: "Prawns", caloriesPer100g: 99, protein: 18.0, carbs: 0.2, fat: 1.4, category: .meat),
        FoodItem(name: "Crab", caloriesPer100g: 97, protein: 19.0, carbs: 0.0, fat: 1.8, category: .meat),
        FoodItem(name: "Mutton", caloriesPer100g: 294, protein: 25.0, carbs: 0.0, fat: 21.0, category: .meat),
        
        // Vegetables
        FoodItem(name: "Gotukola Sambol", caloriesPer100g: 42, protein: 2.3, carbs: 7.0, fat: 0.7, category: .vegetables),
        FoodItem(name: "Malluma", caloriesPer100g: 45, protein: 4.0, carbs: 8.0, fat: 0.5, category: .vegetables),
        FoodItem(name: "Tempered Cabbage", caloriesPer100g: 55, protein: 1.3, carbs: 6.0, fat: 3.2, category: .vegetables),
        FoodItem(name: "Brinjal Curry", caloriesPer100g: 35, protein: 1.0, carbs: 9.0, fat: 0.2, category: .vegetables),
        FoodItem(name: "Okra Curry", caloriesPer100g: 33, protein: 1.9, carbs: 7.0, fat: 0.2, category: .vegetables),
        FoodItem(name: "Green Bean Curry", caloriesPer100g: 35, protein: 1.8, carbs: 8.0, fat: 0.1, category: .vegetables),
        
        // Snacks
        FoodItem(name: "Wade", caloriesPer100g: 347, protein: 14.0, carbs: 32.0, fat: 18.0, category: .snacks),
        FoodItem(name: "Isso Wade", caloriesPer100g: 365, protein: 16.0, carbs: 30.0, fat: 20.0, category: .snacks),
        FoodItem(name: "Fish Cutlet", caloriesPer100g: 165, protein: 12.0, carbs: 15.0, fat: 7.0, category: .snacks),
        FoodItem(name: "Chicken Roll", caloriesPer100g: 250, protein: 15.0, carbs: 25.0, fat: 10.0, category: .snacks),
        FoodItem(name: "Samosa", caloriesPer100g: 262, protein: 5.0, carbs: 26.0, fat: 15.0, category: .snacks),
        FoodItem(name: "Patties", caloriesPer100g: 295, protein: 8.0, carbs: 30.0, fat: 16.0, category: .snacks),
        FoodItem(name: "Kokis", caloriesPer100g: 515, protein: 6.0, carbs: 55.0, fat: 30.0, category: .snacks),
        
        // Sweets
        FoodItem(name: "Kiribath", caloriesPer100g: 97, protein: 2.0, carbs: 22.0, fat: 0.5, category: .sweets),
        FoodItem(name: "Wattalappam", caloriesPer100g: 165, protein: 4.0, carbs: 25.0, fat: 6.0, category: .sweets),
        FoodItem(name: "Kokis", caloriesPer100g: 515, protein: 6.0, carbs: 55.0, fat: 30.0, category: .sweets),
        FoodItem(name: "Aluwa", caloriesPer100g: 380, protein: 3.0, carbs: 85.0, fat: 2.0, category: .sweets),
        FoodItem(name: "Dodol", caloriesPer100g: 320, protein: 2.0, carbs: 75.0, fat: 3.0, category: .sweets),
        FoodItem(name: "Halapa", caloriesPer100g: 180, protein: 3.0, carbs: 40.0, fat: 2.0, category: .sweets),
        
        // Beverages
        FoodItem(name: "King Coconut Water", caloriesPer100g: 19, protein: 0.7, carbs: 3.7, fat: 0.2, category: .beverages),
        FoodItem(name: "Ceylon Tea (Plain)", caloriesPer100g: 1, protein: 0.0, carbs: 0.3, fat: 0.0, category: .beverages),
        FoodItem(name: "Ceylon Tea (with Milk)", caloriesPer100g: 43, protein: 1.6, carbs: 5.5, fat: 1.7, category: .beverages),
        FoodItem(name: "Thambili", caloriesPer100g: 19, protein: 0.7, carbs: 3.7, fat: 0.2, category: .beverages),
        FoodItem(name: "Wood Apple Juice", caloriesPer100g: 134, protein: 7.1, carbs: 31.0, fat: 0.4, category: .beverages),
        
        // Bread & Roti
        FoodItem(name: "Roti (Plain)", caloriesPer100g: 297, protein: 9.0, carbs: 55.0, fat: 5.0, category: .bread),
        FoodItem(name: "Pol Roti", caloriesPer100g: 350, protein: 8.0, carbs: 45.0, fat: 15.0, category: .bread),
        FoodItem(name: "Godamba Roti", caloriesPer100g: 320, protein: 10.0, carbs: 50.0, fat: 10.0, category: .bread),
        FoodItem(name: "Parata", caloriesPer100g: 320, protein: 6.0, carbs: 43.0, fat: 13.0, category: .bread),
        FoodItem(name: "Bread (White)", caloriesPer100g: 265, protein: 9.0, carbs: 49.0, fat: 3.2, category: .bread),
        FoodItem(name: "Bread (Brown)", caloriesPer100g: 247, protein: 13.0, carbs: 41.0, fat: 3.2, category: .bread)
    ]
    
    func searchFoods(query: String) -> [FoodItem] {
        if query.isEmpty {
            return foods
        }
        return foods.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
    
    func getFoodsByCategory(_ category: FoodCategory) -> [FoodItem] {
        return foods.filter { $0.category == category }
    }
}
