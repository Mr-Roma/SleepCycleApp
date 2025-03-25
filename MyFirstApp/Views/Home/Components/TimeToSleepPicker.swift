//
//  TimeToSleepPicker.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 17/03/25.
//

import SwiftUI

struct TimeToSleepPicker: View {
    @Binding var fallAsleepMinutes: Int
    @State private var isExpanded = false
    let minuteOptions = Array(1...120)
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text("\(fallAsleepMinutes) min")
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
            .padding(.horizontal)
            
            if isExpanded {
                Picker("Minutes", selection: $fallAsleepMinutes) {
                    ForEach(minuteOptions, id: \.self) { minute in
                        Text("\(minute) min")
                            .font(.subheadline)
                            .tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
                .background(Color(.systemGray5))
                .cornerRadius(12)
                .onChange(of: fallAsleepMinutes) { _ in
                    withAnimation {
                        isExpanded = false
                    }
                }
            }
            
        }
    }
}
