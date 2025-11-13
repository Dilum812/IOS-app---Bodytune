//
//  BMICalculatorView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-14.
//

import SwiftUI

struct BMICalculatorView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var height: String = "175"
    @State private var weight: String = "68"
    @State private var bmiValue: Double = 0.0
    @State private var bmiCategory: String = ""
    @State private var bmiColor: Color = .green
    @State private var showResult: Bool = false
    @State private var animateValue: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                headerView
                
                Spacer()
                
                // Input Section
                inputSection
                
                // BMI Result Section
                if showResult {
                    bmiResultSection
                        .transition(.scale.combined(with: .opacity))
                }
                
                // Description Section
                if showResult {
                    descriptionSection
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                Spacer()
                
                // Calculate Button
                calculateButton
                
                Spacer(minLength: 100)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            calculateBMI()
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
            
            Text("BMI Calculator")
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
        .padding(.top, 10)
    }
    
    private var inputSection: some View {
        HStack(spacing: 16) {
            // Height Input
            VStack(spacing: 8) {
                Text("Height")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                
                HStack(spacing: 2) {
                    TextField("175", text: $height)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .fixedSize()
                        .onChange(of: height) { _ in
                            calculateBMI()
                        }
                    
                    Text("cm")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.15))
            )
            
            // Weight Input
            VStack(spacing: 8) {
                Text("Weight")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                
                HStack(spacing: 2) {
                    TextField("68", text: $weight)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .fixedSize()
                        .onChange(of: weight) { _ in
                            calculateBMI()
                        }
                    
                    Text("kg")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.15))
            )
        }
    }
    
    private var bmiResultSection: some View {
        VStack(spacing: 16) {
            Text("Your BMI")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
            
            Text(String(format: "%.1f", bmiValue))
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.white)
                .scaleEffect(animateValue ? 1.1 : 1.0)
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: animateValue)
            
            Text(bmiCategory)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(bmiColor)
                )
        }
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.15))
        )
    }
    
    private var descriptionSection: some View {
        Text(getBMIDescription())
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.15))
            )
    }
    
    private var calculateButton: some View {
        Button(action: {
            recalculateBMI()
        }) {
            Text("Recalculate")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.blue)
                )
        }
    }
    
    private func calculateBMI() {
        guard let heightValue = Double(height),
              let weightValue = Double(weight),
              heightValue > 0 else {
            return
        }
        
        let heightInMeters = heightValue / 100
        let calculatedBMI = weightValue / (heightInMeters * heightInMeters)
        
        withAnimation(.easeInOut(duration: 0.5)) {
            bmiValue = calculatedBMI
            updateBMICategory(calculatedBMI)
            showResult = true
        }
    }
    
    private func recalculateBMI() {
        withAnimation(.easeInOut(duration: 0.3)) {
            animateValue.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            calculateBMI()
        }
    }
    
    private func updateBMICategory(_ bmi: Double) {
        switch bmi {
        case ..<18.5:
            bmiCategory = "Underweight"
            bmiColor = .blue
        case 18.5..<25:
            bmiCategory = "Normal Weight"
            bmiColor = .green
        case 25..<30:
            bmiCategory = "Overweight"
            bmiColor = .orange
        default:
            bmiCategory = "Obese"
            bmiColor = .red
        }
    }
    
    private func getBMIDescription() -> String {
        switch bmiValue {
        case ..<18.5:
            return "Your BMI indicates you're underweight. Consider consulting with a healthcare provider about healthy weight gain strategies."
        case 18.5..<25:
            return "Your BMI indicates you're at a healthy weight. Maintain a balanced diet and regular exercise routine."
        case 25..<30:
            return "Your BMI indicates you're overweight. Consider adopting a healthier lifestyle with balanced diet and regular exercise."
        default:
            return "Your BMI indicates obesity. It's recommended to consult with a healthcare provider for personalized advice."
        }
    }
}

#Preview {
    BMICalculatorView()
}
