//
//  OnboardingView.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 18/03/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var isOnboardingComplete = false
    
    var body: some View {
        VStack {
            // Page Tab View for Onboarding Slides
            TabView(selection: $currentPage) {
                OnboardingSlide(
                    imageName: "maskot",
                    title: "Track Your Sleep",
                    description: "Monitor your sleep patterns and improve your rest quality."
                )
                .tag(0)
                
                OnboardingSlide(
                    imageName: "onboard1",
                    title: "Wake Up Refreshed",
                    description: "Get personalized insights to wake up feeling refreshed."
                )
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            // Next/Done Button
            Button(action: {
                if currentPage < 1 {
                    currentPage += 1
                } else {
                    isOnboardingComplete = true
                }
            }) {
                Text(currentPage == 1 ? "Done" : "Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .background(
            NavigationLink(
                destination: ContentView(),
                isActive: $isOnboardingComplete,
                label: { EmptyView() }
            )
        )
        .navigationBarHidden(true) 
    }
}

struct OnboardingSlide: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.primary)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

