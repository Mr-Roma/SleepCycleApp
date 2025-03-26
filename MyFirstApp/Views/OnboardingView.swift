import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var isOnboardingComplete = false
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
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
                        isFirstLaunch = false
                        isOnboardingComplete = true
                    }
                }) {
                    Text(currentPage == 1 ? "Done" : "Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("UnguMuda"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
            .background(
                NavigationLink(destination: ContentView(),
                               isActive: $isOnboardingComplete) {
                    EmptyView()
                }
            )
            .navigationBarHidden(true)
        }
    }
}

struct OnboardingSlide: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 220, height: 220)
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
