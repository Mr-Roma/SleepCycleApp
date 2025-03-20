// HistoryView.swift
import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: SleepViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Sleep History")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.top)
                
                // Weekly Summary Card
                SummaryCard(viewModel: viewModel)
                
                // Past Sleep Sessions (sorted by timestamp)
                ForEach(viewModel.sleepResults.sorted(by: { $0.timestamp > $1.timestamp }), id: \.timestamp) { result in
                    HistoryRow(date: result.timestamp, result: result)
                }
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
    }
}
