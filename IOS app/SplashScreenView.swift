//
//  SplashScreenView.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-10.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            OnboardingView()
        } else {
            GeometryReader { geometry in
                ZStack {
                    // Black background
                    Color.black
                        .ignoresSafeArea()
                    
                    // Logo image - perfectly centered in middle of screen
                    Image("Bodytune logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 460, height: 400)
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height / 2
                        )
                }
            }
            .onAppear {
                // Auto-transition after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
