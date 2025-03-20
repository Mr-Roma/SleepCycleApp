// HistoryRow.swift
import SwiftUI

struct HistoryRow: View {
    var date: Date
    var result: SleepResult
    
    var body: some View {
        Button(action: {
            // Navigate to detailed view
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(date, style: .date)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("\(result.totalCycles) Cycles")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(result.sleepDuration)
                    .font(.subheadline)
                    .foregroundColor(.green)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .padding(.leading)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .shadow(radius: 1)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal)
    }
}

