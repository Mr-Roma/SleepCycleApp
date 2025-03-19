//
//  HistoryRow.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 17/03/25.
//

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
                    
                    Text(result.sleepDuration)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    HStack(alignment: .lastTextBaseline, spacing: 0) {
                        Text("\(result.sleepScore)")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                        
                        Text("/100")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    // Quality label based on score
                    Text(qualityLabel(for: result.sleepScore))
                        .font(.caption)
                        .foregroundColor(qualityColor(for: result.sleepScore))
                }
                
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
    
    private func qualityLabel(for score: Int) -> String {
        switch score {
        case 90...100: return "Excellent"
        case 80..<90: return "Very Good"
        case 70..<80: return "Good"
        case 60..<70: return "Fair"
        default: return "Poor"
        }
    }
    
    private func qualityColor(for score: Int) -> Color {
        switch score {
        case 90...100: return .green
        case 80..<90: return .blue
        case 70..<80: return .yellow
        case 60..<70: return .orange
        default: return .red
        }
    }
}


#Preview {
    HistoryRow(date: Date(), result: .init(sleepScore: 80, sleepDuration: "", deepSleepPercentage: 0.5, remSleepPercentage: 0.3))
}
