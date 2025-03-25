//
//  FormSectionWithInfo.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 24/03/25.
//
import SwiftUI

struct FormSectionWithInfo<Content: View>: View {
    let title: String
    let infoDestination: AnyView
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Text(title)
                    .font(.headline)
                
                NavigationLink(destination: infoDestination) {
                    Image(systemName: "info.circle")
                        .foregroundColor(Color("UnguMuda"))
                }
                
                Spacer() // Pushes content to the left
            }
            .padding(.horizontal)
            
            content
        }
    }
}
