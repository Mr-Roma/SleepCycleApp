//
//  DataCard.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 17/03/25.
//

import SwiftUI

struct DataCard: View {
    var title: String
    var subtitle: String
    var data: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(Color("UnguMuda"))
                }
                
                Spacer()
                
                Text(data)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .shadow(radius: 2)
        .cornerRadius(20)
        .shadow(radius: 4)
    }
}
