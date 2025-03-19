////
////  SplashView.swift
////  MyFirstApp
////
////  Created by Romario Marcal on 18/03/25.
////
//
//import SwiftUI
//
//struct SplashView: View {
//    @State private var isActive = false
//    
//    var body: some View {
//        VStack {
//            // App Logo
//            Image(systemName: "moon.stars.fill")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 150, height: 150)
//                .foregroundColor(.blue)
//            
//            // App Name
//            Text("SleepCycle")
//                .font(.system(size: 32, weight: .bold, design: .rounded))
//                .foregroundColor(.primary)
//                .padding(.top, 20)
//        }
//        .onAppear {
//            // Automatically navigate to OnboardingView after 2 seconds
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                isActive = true
//            }
//        }
//        .background(
//            NavigationLink(
//                destination: OnboardingView(),
//                isActive: $isActive,
//                label: { EmptyView() }
//            )
//        )
//    }
//}


import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                // App Logo
                Image(systemName: "moon.stars.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)
                
                // App Name
                Text("SleepCycle")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.top, 20)
            }
            .onAppear {
                // Automatically navigate to OnboardingView after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
            .background(
                NavigationLink(
                    destination: OnboardingView(),
                    isActive: $isActive,
                    label: { EmptyView() }
                )
            )
        }
        .navigationBarHidden(true) 
        .navigationViewStyle(StackNavigationViewStyle()) // Use stack navigation for full-screen transitions
        
        
    }
}


#Preview {
    SplashView()
}
