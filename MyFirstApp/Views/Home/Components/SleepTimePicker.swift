//
//  WakeUpTimePicker.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 17/03/25.
//

import SwiftUI


struct SleepTimePicker: View {
    @Binding var sleepTime: Date
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text("\(sleepTime, formatter: timeFormatter)")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(Color("UnguMuda"))
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)
                
            }
            
            if isExpanded {
                DatePicker("", selection: $sleepTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .frame(height: 150)
                    .background(Color(.systemGray5))
                    .cornerRadius(12)
                    .onChange(of: sleepTime) { _ in
                        withAnimation {
                            isExpanded = false
                        }
                    }
            }
        }
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
}


