import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel = SleepViewModel()
    @State private var selectedTab: Tab = .home
    
    // Create ModelContainer with multiple models
    private let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SleepResult.self,
            SleepAlternative.self  // Add SleepAlternative to the schema
        ])
        
        do {
            return try ModelContainer(for: schema)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    enum Tab {
        case home, history
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(viewModel: viewModel)
                .modelContainer(sharedModelContainer)
                .tabItem {
                    Label("Calculate", systemImage: "moon.zzz.fill")
                }
                .tag(Tab.home)
            
            HistoryView()
                .modelContainer(sharedModelContainer)
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
                .tag(Tab.history)
        }
        .navigationBarHidden(true)
        .accentColor(Color("UnguMuda"))
    }
}
