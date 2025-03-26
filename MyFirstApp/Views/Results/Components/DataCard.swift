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
    var iconName: String? = nil
    var accentColor: Color = .blue // Default accent color
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon container (optional)
            if let iconName = iconName {
                ZStack {
                    Circle()
                        .fill(accentColor.opacity(0.2))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: iconName)
                        .foregroundColor(accentColor)
                        .font(.system(size: 18, weight: .semibold))
                }
            }
            
            // Text content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Data value
            Text(data)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(accentColor)
        }
        .padding(16)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
