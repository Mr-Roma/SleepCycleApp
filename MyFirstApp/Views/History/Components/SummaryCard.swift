// SummaryCard.swift
import SwiftUI

struct SummaryCard: View {
    @ObservedObject var viewModel: SleepViewModel
    
    var body: some View {
        let totalCycles = viewModel.sleepResults.map { $0.totalCycles }.reduce(0, +)
        
        VStack(alignment: .leading, spacing: 10) {
            Text("Weekly Summary")
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Total Sleep Cycles")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("\(totalCycles)")
                        .font(.title)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
                
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}


