//
//  AgeDropdown.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 17/03/25.
//
import SwiftUI

struct AgeDropdown: View {
    @Binding var selectedOption: String
    @State private var isExpanded = false
    
    let options = ["Children", "Teenagers", "Adults", "Elderly"]
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(selectedOption)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedOption = option
                            withAnimation {
                                isExpanded = false
                            }
                        }) {
                            Text(option)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(
                                    selectedOption == option ?
                                        Color.blue.opacity(0.1) :
                                        Color(.systemBackground)
                                )
                        }
                        Divider()
                    }
                }
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .shadow(radius: 2)
            }
        }
    }
}

