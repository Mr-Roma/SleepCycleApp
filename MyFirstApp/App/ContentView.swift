import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SleepViewModel()
    @State private var selectedTab: Tab = .home
    
    enum Tab {
        case home, history
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)
            
            HistoryView(viewModel: viewModel)
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
                .tag(Tab.history)
        }
        .navigationBarHidden(true) // Hide the navigation bar
    }
}
