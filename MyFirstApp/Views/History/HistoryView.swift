import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: SleepViewModel
    @Query var sleepResults: [SleepResult]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sleep History")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .padding(.top)
            
            List {
                ForEach(sleepResults.sorted(by: { $0.timestamp > $1.timestamp }), id: \.timestamp) { result in
                    HistoryRow(date: result.timestamp, result: result)
                        .frame(maxWidth: .infinity) // Make card take full width
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 8)// Remove default list row padding
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deleteItem(result)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                .listRowSeparator(.hidden) // Hide list separators
            }
            .listStyle(PlainListStyle())
        }
        .padding(.bottom, 20)
    }
    
    func deleteItem(_ result: SleepResult) {
        modelContext.delete(result)
        do {
            try modelContext.save()
        } catch {
            print("Error deleting sleep entry: \(error.localizedDescription)")
        }
    }
    
    func printSleepData() {
        print("📊 Sleep Data (Total: \(sleepResults.count))")
        for result in sleepResults {
            print("""
            -------------------------------
            🕒 Duration: \(result.sleepDuration))
            😴 Deep Sleep: \(result.deepSleepPercentage)%
            💤 REM Sleep: \(result.remSleepPercentage)%
            🔄 Total Cycles: \(result.totalCycles)
            📅 Timestamp: \(result.timestamp)
            """)
        }
    }
}
