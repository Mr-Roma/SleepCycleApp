//
//  HistoryView.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 17/03/25.


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
                
                // Weekly Average Card
                SummaryCard(viewModel: viewModel)
                
                // Past Sleep Sessions
                ForEach(0..<viewModel.sleepResults.count, id: \.self) { index in
                    let date = Calendar.current.date(byAdding: .day, value: -index, to: Date()) ?? Date()
                    let result = viewModel.sleepResults[index]
                    
                    HistoryRow(date: date, result: result)
                }
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
    }
}


#Preview {
    HistoryView(viewModel: SleepViewModel())
}





