//
//  SplashScreenView.swift
//  Phone Guardian
//
//  Created by MacBook Pro M1 Pro on 12/2/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var opacity = 0.0
    
    var body: some View {
        if isActive {
            BaseView() // Navigate to your main content view
        } else {
            ZStack {
                // Background color gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.green]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    // App Icon
                    Image("AppIcon") // Replace with your app's icon name
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                    
                    // App Name
                    Text("PhoneGuardian")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    // Tagline
                    Text("Secure. Protect. Relax.")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 8)
                }
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

// Preview
#Preview {
    SplashScreenView()
}
