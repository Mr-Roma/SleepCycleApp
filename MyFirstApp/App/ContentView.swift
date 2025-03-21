import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel = SleepViewModel()
    @State private var selectedTab: Tab = .home
    @Environment(\.modelContext) private var modelContext
    
    var sharedModelContainer: ModelContainer = {
            let schema = Schema([SleepResult.self]) // Pastikan model sudah benar
            let container = try! ModelContainer(for: schema)
            return container
        }()
    
    enum Tab {
        case home, history
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(viewModel: viewModel)
                .modelContainer(sharedModelContainer)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)
            
            HistoryView(viewModel: viewModel)
                .modelContainer(sharedModelContainer)
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
                .tag(Tab.history)
        }
        .navigationBarHidden(true) // Hide the navigation bar
    }
}
