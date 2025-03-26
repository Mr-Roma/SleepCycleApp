//
//  ConsistentTextfieldStyle.swift
//  MyFirstApp
//
//  Created by Romario Marcal on 26/03/25.
//

import SwiftUI

struct ConsistentTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 50) // Fixed height for all fields
            .frame(maxWidth: .infinity) // Equal width
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1))
    }
}
