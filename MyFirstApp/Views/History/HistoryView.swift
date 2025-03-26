
import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SleepResult.timestamp, order: .reverse) var sleepResults: [SleepResult]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    if sleepResults.isEmpty {
                        EmptyHistoryView()
                    } else {
                        // Latest result summary card
                        LatestResultCard(result: sleepResults.first!)
                            .padding(.horizontal, 16)
                            .padding(.top, 20)
                    }
                }
            }
            .navigationTitle("Sleep History")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
        }
    }
    
    private func deleteItem(_ result: SleepResult) {
        modelContext.delete(result)
        do {
            try modelContext.save()
        } catch {
            print("Error deleting sleep entry: \(error.localizedDescription)")
        }
    }
}

// MARK: - Subviews

struct LatestResultCard: View {
    let result: SleepResult
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Latest Sleep")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text(result.timestamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 20) {
                MetricPill(value: "\(result.totalCycles)", label: "Cycles", color: Color("UnguMuda"))
                MetricPill(value: result.sleepDuration, label: "Duration", color: .blue)
            }
        }
        .padding(16)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct MetricPill: View {
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(width: 80)
        .padding(8)
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}

struct EmptyHistoryView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "moon.zzz")
                .font(.system(size: 40))
                .foregroundColor(Color("UnguMuda").opacity(0.5))
            
            Text("No Sleep Records")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Your sleep history will appear here after tracking")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding(40)
    }
}
