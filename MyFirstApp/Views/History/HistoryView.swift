
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
    @Query(sort: \SleepAlternative.timestamp)
    var sleepAlter: [SleepAlternative]

    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Main Card Content
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
                
                VStack(spacing: 20) {
                    HStack{
                        MetricPill(value: "\(result.totalCycles)", label: "Cycles", color: Color("UnguMuda"))
                        MetricPill(value: result.sleepDuration, label: "Duration", color: Color("Kuning"))
                    }
                    HStack{
                        MetricPill(value: result.deepSleepPercentage, label: "Best Sleep Time", color: Color("Kuning"))
                        MetricPill(value: result.remSleepPercentage, label: "Wake Up Time", color: Color("UnguMuda"))
                    }
                }
                
                // Expand/Collapse Indicator
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
            }
            .padding(16)
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
            .onTapGesture {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            }
            
            // Expandable Content
            if isExpanded {
                VStack(spacing: 10) {
                    ForEach(sleepAlter.prefix(4)) { alternative in
                        DataCard(
                            title: "Sleep at \(alternative.WakeUpTime)",
                            subtitle: "Wake up at \(alternative.SleepTime)",
                            data: alternative.sleepDuration,
                            iconName: "bed.double.fill",
                            accentColor: Color("UnguMuda") // Kept UnguMuda as requested
                        )
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
                .padding(.top,10)
                
                   
                }
                
            }
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
        .frame(width: 100)
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
