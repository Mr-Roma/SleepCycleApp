// HistoryView.swift
import SwiftUI
import _SwiftData_SwiftUI

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: SleepViewModel
    @Query var sleepResults: [SleepResult]
//    @Query(sort: \SleepResult.timestamp, order: .reverse) var sleepResults: [SleepResult]
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Sleep History")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.top)
                
                // Weekly Summary Card
//                SummaryCard(viewModel: viewModel)
                
                // Past Sleep Sessions (sorted by timestamp)
                ForEach(sleepResults.sorted(by: { $0.timestamp > $1.timestamp }), id: \.timestamp) { result in
                    HistoryRow(date: result.timestamp, result: result)
                }
                
                Spacer()
            }
            .padding(.bottom, 20)
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
